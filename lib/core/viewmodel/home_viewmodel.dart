import 'base_viewmodel.dart';
import 'package:flutter/material.dart';
import '../view/screens/profile_view.dart';

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
    }
    notifyListeners();
  }
} 