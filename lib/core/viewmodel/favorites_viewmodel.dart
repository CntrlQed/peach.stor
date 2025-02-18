import 'base_viewmodel.dart';
import 'package:flutter/material.dart';

class FavoritesViewModel extends BaseViewModel {
  void onNavItemTapped(int index, BuildContext context) {
    if (index != 2) {
      // If not favorites tab
      setState(ViewState.busy);
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/categories');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/orders');
          break;
        case 4:
          Navigator.pushReplacementNamed(context, '/profile');
          break;
      }
      setState(ViewState.idle);
    }
  }
}
