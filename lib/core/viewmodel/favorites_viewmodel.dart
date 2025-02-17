import 'base_viewmodel.dart';
// ignore: unused_import
import 'package:flutter/material.dart';

class FavoritesViewModel extends BaseViewModel {
  void onNavItemTapped(int index) {
    if (index != 2) { // If not favorites tab
      setState(ViewState.busy);
      // TODO: Implement navigation to other screens
      setState(ViewState.idle);
    }
  }
} 