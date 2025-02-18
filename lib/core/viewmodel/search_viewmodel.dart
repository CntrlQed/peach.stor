import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

class SearchViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _searchQuery = '';
  String? _selectedCategory;
  final List<Product> _allProducts = [];
  List<Product> _searchResults = [];

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  List<Product> get searchResults => _searchResults;

  // Sample categories
  final List<String> categories = [
    'Dresses',
    'Shirts',
    'Pants',
    'Accessories',
    'Shoes',
  ];

  SearchViewModel() {
    _loadProducts();
  }

  void _loadProducts() {
    _isLoading = true;
    notifyListeners();

    // Simulating API call
    Future.delayed(const Duration(milliseconds: 500), () {
      _allProducts.addAll([
        Product(
          id: 1,
          name: 'Beige Shirt',
          price: 2500,
          imageUrl: 'assets/costume.png',
          category: 'Shirts',
        ),
        Product(
          id: 2,
          name: 'Black Dress',
          price: 3500,
          imageUrl: 'assets/costume.png',
          category: 'Dresses',
        ),
        Product(
          id: 3,
          name: 'Blue Jeans',
          price: 1800,
          imageUrl: 'assets/costume.png',
          category: 'Pants',
        ),
        Product(
          id: 4,
          name: 'Silver Necklace',
          price: 1200,
          imageUrl: 'assets/costume.png',
          category: 'Accessories',
        ),
      ]);

      _filterProducts();
      _isLoading = false;
      notifyListeners();
    });
  }

  void onSearchQueryChanged(String query) {
    _searchQuery = query;
    _filterProducts();
    notifyListeners();
  }

  void setCategory(String? category) {
    _selectedCategory = category;
    _filterProducts();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filterProducts();
    notifyListeners();
  }

  void _filterProducts() {
    _searchResults = _allProducts.where((product) {
      final matchesQuery = product.name.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      final matchesCategory =
          _selectedCategory == null || product.category == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  void onProductTapped(BuildContext context, Product product) {
    // TODO: Navigate to product details
    print('Product tapped: ${product.name}');
  }
}
