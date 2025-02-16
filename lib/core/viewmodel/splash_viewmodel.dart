import 'dart:async';
import 'base_viewmodel.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel() {
    _initSplash();
  }

  Future<void> _initSplash() async {
    setState(ViewState.busy);
    
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 2));
    
    // Navigate to starting screen
    // TODO: Implement navigation
    
    setState(ViewState.idle);
  }
} 