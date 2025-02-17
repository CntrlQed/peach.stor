// ignore: unused_import
import 'package:flutter/material.dart';
import 'base_viewmodel.dart';

class ProfileViewModel extends BaseViewModel {
  void logout() {
    // TODO: Implement logout logic
  }

  void onNavItemTapped(int index) {
    if (index != 4) { // If not profile tab
      setState(ViewState.busy);
      // TODO: Implement navigation to other screens
      setState(ViewState.idle);
    }
  }
} 