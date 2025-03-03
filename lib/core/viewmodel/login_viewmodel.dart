import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    debugPrint('📝 Login attempt with email: ${emailController.text}');
    
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      debugPrint('⚠️ Login validation failed: Empty fields');
      setError('Please fill in all fields');
      return;
    }

    try {
      debugPrint('🔄 Setting view state to busy');
      setState(ViewState.busy);
      
      debugPrint('🔐 Calling auth service signIn');
      await _authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      
      // Wait for auth state to be properly updated
      await Future.delayed(const Duration(milliseconds: 500));
      
      debugPrint('✅ Sign in successful, checking if context is mounted');
      if (!context.mounted) {
        debugPrint('❌ Context is not mounted, cannot navigate');
        return;
      }

      final userType = await _authService.getUserType();
      debugPrint('LoginViewModel: User type: $userType');

      if (userType == 'user') {
        debugPrint('🔄 Navigating to home screen');
        await Navigator.pushReplacementNamed(context, '/home');
      } else if (userType == 'carrier') {
        debugPrint('🔄 Navigating to map screen');
        await Navigator.pushReplacementNamed(context, '/map');
      }
      setState(ViewState.idle);
      
    } catch (e) {
      debugPrint('❌ Login error caught in view model: $e');
      setError(e.toString());
      setState(ViewState.error);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      debugPrint('🔄 Setting view state to busy for Google sign in');
      setState(ViewState.busy);
      
      debugPrint('🔐 Calling auth service signInWithGoogle');
      await _authService.signInWithGoogle();
      
      // Wait for auth state to be properly updated
      await Future.delayed(const Duration(milliseconds: 500));
      
      debugPrint('✅ Google sign in successful, checking if context is mounted');
      if (!context.mounted) {
        debugPrint('❌ Context is not mounted, cannot navigate');
        return;
      }

      debugPrint('🔄 Navigating to home screen');
      await Navigator.pushReplacementNamed(context, '/home');
      setState(ViewState.idle);
      
    } catch (e) {
      debugPrint('❌ Google sign in error caught in view model: $e');
      setError(e.toString());
      setState(ViewState.error);
    }
  }

  void navigateToSignUp(BuildContext context) {
    debugPrint('🔄 Navigating to sign up screen');
    Navigator.pushNamed(context, '/signup');
  }

  @override
  void dispose() {
    debugPrint('🧹 Disposing login view model');
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
} 