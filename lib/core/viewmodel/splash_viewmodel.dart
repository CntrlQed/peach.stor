import 'package:flutter/material.dart';
import 'base_viewmodel.dart';
import '../view/screens/starting_view.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel() {
    _init();
  }

  Future<void> _init() async {
    setState(ViewState.busy);
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 2));
    setState(ViewState.idle);
  }

  void navigateToStartingView(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const StartingView()),
    );
  }
} 