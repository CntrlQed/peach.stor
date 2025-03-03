import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'base_viewmodel.dart';

class SignUpViewModel extends BaseViewModel {
  final _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    debugPrint('📝 Sign up attempt with email: ${emailController.text}');
    
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      debugPrint('⚠️ Sign up validation failed: Empty fields');
      setError('Please fill in all fields');
      return;
    }

    try {
      debugPrint('🔄 Setting view state to busy');
      setState(ViewState.busy);
      
      debugPrint('🔐 Calling auth service signUp');
      await _authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      
      debugPrint('✅ Sign up successful, checking if context is mounted');
      if (context.mounted) {
        final userType = await _authService.getUserType();
        debugPrint('SignUpViewModel: User type: $userType');

        if (userType == 'user') {
          debugPrint('🔄 Navigating to home screen');
          await Navigator.pushReplacementNamed(context, '/home');
        } else if (userType == 'carrier') {
          debugPrint('🔄 Navigating to map screen');
          await Navigator.pushReplacementNamed(context, '/map');
        }
      }
    } catch (e) {
      debugPrint('❌ Sign up error caught in view model: $e');
      setError(e.toString());
    } finally {
      debugPrint('🔄 Setting view state back to idle');
      setState(ViewState.idle);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      debugPrint('🔄 Setting view state to busy for Google sign in');
      setState(ViewState.busy);
      
      debugPrint('🔐 Calling auth service signInWithGoogle');
      await _authService.signInWithGoogle();
      
      debugPrint('✅ Google sign in successful, checking if context is mounted');
      if (context.mounted) {
        debugPrint('🔄 Navigating to home screen');
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      debugPrint('❌ Google sign in error caught in view model: $e');
      setError(e.toString());
    } finally {
      debugPrint('🔄 Setting view state back to idle');
      setState(ViewState.idle);
    }
  }

  @override
  void dispose() {
    debugPrint('🧹 Disposing signup view model');
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
} 