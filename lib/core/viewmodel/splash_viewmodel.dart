import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'base_viewmodel.dart';

class SplashViewModel extends BaseViewModel {
  final AuthService _authService = AuthService();

  Future<void> checkAuthAndNavigate(BuildContext context) async {
    try {
      setState(ViewState.busy);
      
      final isLoggedIn = await _authService.isLoggedIn();
      debugPrint('SplashViewModel: User logged in status: $isLoggedIn');
      
      if (isLoggedIn) {
        final userType = await _authService.getUserType();
        debugPrint('SplashViewModel: User type: $userType');
        
        if (userType == 'user') {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (userType == 'carrier') {
          Navigator.pushReplacementNamed(context, '/map');
        } else {
          // If user type is not set, go to choose view
          Navigator.pushReplacementNamed(context, '/choose');
        }
      } else {
        // Not logged in, go to choose view
        Navigator.pushReplacementNamed(context, '/choose');
      }
    } catch (e) {
      debugPrint('SplashViewModel Error: $e');
      // On error, default to choose view
      Navigator.pushReplacementNamed(context, '/choose');
    } finally {
      setState(ViewState.idle);
    }
  }
} 
