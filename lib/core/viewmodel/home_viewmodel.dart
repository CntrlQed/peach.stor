import 'base_viewmodel.dart';
import 'package:flutter/material.dart';
import '../view/screens/profile_view.dart';
import '../view/screens/favorites_view.dart';
import '../view/screens/product_details_view.dart';

class HomeViewModel extends BaseViewModel {
  int _currentIndex = 0;
  
  int get currentIndex => _currentIndex;
  
  void setIndex(int index, BuildContext context) {
    _currentIndex = index;
    if (index == 4) { // Profile tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileView()),
      );
    } else if (index == 2) { // Favorites tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FavoritesView()),
      );
    }
    notifyListeners();
  }

  void onProductTapped(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductDetailsView()),
    );
  }
} 