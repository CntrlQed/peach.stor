import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'base_viewmodel.dart';

class ChooseViewModel extends BaseViewModel {
  final _authService = AuthService();

  Future<void> onUserSelected(BuildContext context) async {
    setState(ViewState.busy);
    try {
      await _authService.setUserType('user');
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      debugPrint('Error setting user type: $e');
    }
    setState(ViewState.idle);
  }

  Future<void> onCarrierSelected(BuildContext context) async {
    setState(ViewState.busy);
    try {
      await _authService.setUserType('carrier');
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      debugPrint('Error setting carrier type: $e');
    }
    setState(ViewState.idle);
  }
} 