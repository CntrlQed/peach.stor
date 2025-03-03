import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_links/app_links.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  
  static const String _userKey = 'user_profile';
  static const String _authTypeKey = 'auth_type';
  static const String _userTypeKey = 'user_type';
  static const String _tokenKey = 'token';
  
  final _supabase = Supabase.instance.client;
  final _appLinks = AppLinks();
  
  bool get isAuthenticated => _supabase.auth.currentUser != null;
  User? get currentUser => _supabase.auth.currentUser;

  AuthService._internal() {
    debugPrint('🔧 AuthService initialized');
    _initializeService();
  }

  Future<void> _initializeService() async {
    try {
      debugPrint('🔄 Checking initial auth state...');
      final session = await _supabase.auth.currentSession;
      debugPrint('🔑 Current auth state: ${session != null ? 'Logged in' : 'Logged out'}');
      
      // Listen to auth state changes
      _supabase.auth.onAuthStateChange.listen((data) async {
        debugPrint('🔄 Auth state changed: ${data.event}');
        debugPrint('👤 User: ${data.session?.user.email}');
        
        // Handle auth state change
        await _handleAuthStateChange(data);
      });

      // Listen to deep links
      _appLinks.uriLinkStream.listen((uri) {
        debugPrint('🔗 Deep link received: $uri');
        _handleDeepLink(uri);
      });

      // Get initial link if app was opened with it
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        debugPrint('🔗 Initial deep link: $initialUri');
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      debugPrint('⚠️ Error initializing auth service: $e');
    }
  }

  void _handleDeepLink(Uri uri) {
    debugPrint('🔗 Handling deep link: $uri');
    if (uri.path.contains('login-callback')) {
      debugPrint('✅ OAuth callback received');
    }
  }

  Future<void> _handleAuthStateChange(AuthState state) async {
    try {
      if (state.event == AuthChangeEvent.signedIn) {
        debugPrint('✅ User signed in, saving session data');
        if (state.session?.user != null) {
          await _saveUserData(state.session!.user, state.session!);
        }
      } else if (state.event == AuthChangeEvent.signedOut) {
        debugPrint('👋 User signed out, clearing session data');
        await _clearUserData();
      }
    } catch (e) {
      debugPrint('⚠️ Error handling auth state change: $e');
    }
  }

  Future<bool> _validateConnection() async {
    try {
      debugPrint('🌐 Validating Supabase connection...');
      // Try a simple health check by checking auth status
      final session = await _supabase.auth.currentSession;
      debugPrint('✅ Supabase connection successful');
      debugPrint('📱 Current session: ${session != null ? 'Active' : 'None'}');
      return true;
    } catch (e) {
      debugPrint('❌ Supabase connection failed: $e');
      return false;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('🔐 Starting sign in process for email: $email');

      if (!email.contains('@')) {
        throw Exception('Please enter a valid email address');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters long');
      }

      debugPrint('🔐 Sending sign in request...');
      final AuthResponse response;
      try {
        response = await _supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
      } on AuthException catch (e) {
        debugPrint('❌ Supabase auth error: ${e.message}');
        throw Exception(e.message);
      } catch (e) {
        debugPrint('❌ Sign in request failed: $e');
        throw Exception('Failed to connect to authentication service. Please check your internet connection.');
      }

      debugPrint('📱 Processing sign in response...');
      if (response.user == null || response.session == null) {
        debugPrint('❌ Invalid sign in response: user or session is null');
        throw Exception('Invalid credentials or account not found');
      }

      debugPrint('✅ Sign in successful for: ${response.user!.email}');
      await _saveUserData(response.user!, response.session!);

    } catch (e, stackTrace) {
      debugPrint('❌ Sign in error: $e');
      debugPrint('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('🔐 Starting sign up process for email: $email');

      // Clear any existing sessions first
      await signOut().catchError((e) {
        debugPrint('⚠️ Error clearing existing session: $e');
      });

      debugPrint('🔐 Sending sign up request...');
      final AuthResponse response;
      try {
        response = await _supabase.auth.signUp(
          email: email,
          password: password,
        );
      } catch (e) {
        debugPrint('❌ Sign up request failed: $e');
        throw Exception('Failed to connect to authentication service. Please check your internet connection.');
      }

      debugPrint('📱 Processing sign up response...');
      if (response.user == null) {
        debugPrint('❌ Invalid sign up response: user is null');
        throw Exception('Failed to create account. Please try again.');
      }

      debugPrint('✅ Sign up successful for: ${response.user!.email}');
      await _saveUserData(response.user!, response.session!);

    } catch (e, stackTrace) {
      debugPrint('❌ Sign up error: $e');
      debugPrint('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      debugPrint('🔐 Starting Google sign in process');

      debugPrint('🔐 Initiating Google OAuth flow...');
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'peachstore://login-callback',
        queryParams: {
          'access_type': 'offline',
          'prompt': 'select_account',
        },
      );

      if (!response) {
        debugPrint('❌ Google sign in flow not initiated');
        throw Exception('Failed to start Google sign in. Please try again.');
      }

      debugPrint('✅ Google sign in flow initiated successfully');
      
      // Save auth type as Google
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_authTypeKey, 'google');
      
      // Wait for auth state to change with longer timeout
      bool authenticated = false;
      for (int i = 0; i < 30; i++) {
        debugPrint('🔄 Checking auth state... attempt ${i + 1}');
        final session = await _supabase.auth.currentSession;
        if (session?.user != null) {
          authenticated = true;
          debugPrint('✅ User authenticated successfully');
          await _saveUserData(session!.user, session!);
          break;
        }
        await Future.delayed(const Duration(seconds: 1));
      }
      
      if (!authenticated) {
        debugPrint('❌ Google sign in timed out');
        throw Exception('Google sign in process took too long. Please check if you completed the sign in in your browser.');
      }

    } catch (e, stackTrace) {
      debugPrint('❌ Google sign in error: $e');
      debugPrint('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      debugPrint('🔐 Starting sign out process');
      
      await _supabase.auth.signOut();
      await _clearUserData();
      
      debugPrint('✅ Sign out completed');
    } catch (e, stackTrace) {
      debugPrint('❌ Sign out error: $e');
      debugPrint('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> _saveUserData(User user, Session session) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Save user email
      await prefs.setString(_userKey, user.email ?? '');
      // Save user ID for extra persistence
      await prefs.setString('${_userKey}_id', user.id);
      // Save session token
      await prefs.setString(_tokenKey, session.accessToken);
      debugPrint('💾 User data and session token saved successfully');
    } catch (e) {
      debugPrint('⚠️ Error saving user data: $e');
    }
  }

  Future<void> _clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      await prefs.remove('${_userKey}_id');
      await prefs.remove(_authTypeKey);
      await prefs.remove(_userTypeKey);
      await prefs.remove(_tokenKey);
      debugPrint('💾 User data cleared successfully');
    } catch (e) {
      debugPrint('⚠️ Error clearing user data: $e');
    }
  }

  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  Future<void> setUserType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTypeKey, type);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final session = _supabase.auth.currentSession;
      final isLoggedIn = session != null && session.user != null;
      debugPrint('AuthService: Checking login status. Is logged in: $isLoggedIn');
      return isLoggedIn;
    } catch (e) {
      debugPrint('AuthService Error checking login status: $e');
      return false;
    }
  }
} 