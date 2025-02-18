import 'base_viewmodel.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../view/screens/profile_view.dart';
import '../view/screens/favorites_view.dart';
import '../view/screens/product_details_view.dart';

class HomeViewModel extends BaseViewModel {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index, BuildContext context) {
    if (index != _currentIndex) {
      setState(ViewState.busy);
      switch (index) {
        case 0:
          // Already on home
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/categories');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/favorites');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/orders');
          break;
        case 4:
          Navigator.pushReplacementNamed(context, '/profile');
          break;
      }
      _currentIndex = index;
      setState(ViewState.idle);
    }
  }

  void onProductTapped(BuildContext context, Product product) {
    Navigator.pushNamed(
      context,
      '/product-details',
      arguments: product,
    );
  }
}
