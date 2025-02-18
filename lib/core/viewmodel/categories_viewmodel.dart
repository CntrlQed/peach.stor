import 'package:flutter/material.dart';
import 'base_viewmodel.dart';

class Category {
  final int id;
  final String name;
  final String imageUrl;
  final int itemCount;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.itemCount,
    required this.description,
  });
}

class CategoriesViewModel extends BaseViewModel {
  bool _isLoading = false;
  late Category _featuredCategory;
  final List<Category> _categories = [];

  bool get isLoading => _isLoading;
  Category get featuredCategory => _featuredCategory;
  List<Category> get categories => _categories;

  CategoriesViewModel() {
    _loadCategories();
  }

  void _loadCategories() {
    _isLoading = true;
    notifyListeners();

    // Simulating API call
    Future.delayed(const Duration(milliseconds: 500), () {
      _featuredCategory = Category(
        id: 1,
        name: 'Summer Collection',
        imageUrl: 'assets/costume.png',
        itemCount: 150,
        description: 'Latest summer fashion trends',
      );

      _categories.addAll([
        Category(
          id: 2,
          name: 'Dresses',
          imageUrl: 'assets/costume.png',
          itemCount: 45,
          description: 'Elegant dresses for all occasions',
        ),
        Category(
          id: 3,
          name: 'Shirts',
          imageUrl: 'assets/costume.png',
          itemCount: 38,
          description: 'Casual and formal shirts',
        ),
        Category(
          id: 4,
          name: 'Pants',
          imageUrl: 'assets/costume.png',
          itemCount: 32,
          description: 'Comfortable pants and jeans',
        ),
        Category(
          id: 5,
          name: 'Accessories',
          imageUrl: 'assets/costume.png',
          itemCount: 65,
          description: 'Complete your look with our accessories',
        ),
        Category(
          id: 6,
          name: 'Shoes',
          imageUrl: 'assets/costume.png',
          itemCount: 28,
          description: 'Footwear for every style',
        ),
      ]);

      _isLoading = false;
      notifyListeners();
    });
  }

  void onCategoryTapped(Category category) {
    // TODO: Navigate to category details
    print('Category tapped: ${category.name}');
  }

  void onNavItemTapped(int index, BuildContext context) {
    if (index != 1) {
      // If not categories tab
      setState(ViewState.busy);
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
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
      setState(ViewState.idle);
    }
  }
}
