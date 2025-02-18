import 'package:flutter/material.dart';
import '../models/product.dart';
import 'base_viewmodel.dart';

class ProductDetailsViewModel extends BaseViewModel {
  final Product product;
  bool _isFavorite = false;
  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  ProductDetailsViewModel(this.product) {
    // Initialize with first color and size if available
    if (product.colors.isNotEmpty) {
      _selectedColor = product.colors.first;
    }
    if (product.sizes.isNotEmpty) {
      _selectedSize = product.sizes.first;
    }
  }

  // Getters
  bool get isFavorite => _isFavorite;
  String? get selectedColor => _selectedColor;
  String? get selectedSize => _selectedSize;
  int get quantity => _quantity;

  // Methods
  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
    // TODO: Update favorite status in backend
  }

  void setColor(String color) {
    if (product.colors.contains(color)) {
      _selectedColor = color;
      notifyListeners();
    }
  }

  void setSize(String size) {
    if (product.sizes.contains(size)) {
      _selectedSize = size;
      notifyListeners();
    }
  }

  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  Future<void> addToCart() async {
    try {
      // Validate selection
      if (product.colors.isNotEmpty && _selectedColor == null) {
        throw Exception('Please select a color');
      }
      if (product.sizes.isNotEmpty && _selectedSize == null) {
        throw Exception('Please select a size');
      }

      setState(ViewState.busy);

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // TODO: Add to cart logic
      print('Adding to cart: ${product.name}');
      print('Color: $_selectedColor');
      print('Size: $_selectedSize');
      print('Quantity: $_quantity');

      setState(ViewState.success, 'Added to cart successfully');
    } catch (e) {
      setState(ViewState.error, e.toString());
    }
  }

  void onNavItemTapped(int index) {
    setState(ViewState.busy);
    // TODO: Implement navigation
    setState(ViewState.idle);
  }
}
