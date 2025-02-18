import 'package:flutter/material.dart';

class CartItem {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartViewModel extends ChangeNotifier {
  bool _isLoading = false;
  final List<CartItem> _cartItems = [];
  double _totalAmount = 0;

  bool get isLoading => _isLoading;
  List<CartItem> get cartItems => _cartItems;
  double get totalAmount => _totalAmount;

  void addItem(CartItem item) {
    final existingItem = _cartItems.firstWhere(
      (element) => element.id == item.id,
      orElse: () => item,
    );

    if (!_cartItems.contains(existingItem)) {
      _cartItems.add(item);
      _calculateTotal();
      notifyListeners();
    } else {
      incrementQuantity(item.id);
    }
  }

  void removeItem(int id) {
    _cartItems.removeWhere((item) => item.id == id);
    _calculateTotal();
    notifyListeners();
  }

  void incrementQuantity(int id) {
    final item = _cartItems.firstWhere((item) => item.id == id);
    item.quantity++;
    _calculateTotal();
    notifyListeners();
  }

  void decrementQuantity(int id) {
    final item = _cartItems.firstWhere((item) => item.id == id);
    if (item.quantity > 1) {
      item.quantity--;
      _calculateTotal();
      notifyListeners();
    } else {
      removeItem(id);
    }
  }

  void _calculateTotal() {
    _totalAmount = _cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  void proceedToCheckout() {
    // TODO: Implement checkout logic
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      _isLoading = false;
      notifyListeners();
      // Navigate to checkout page
    });
  }

  // Add some dummy data for testing
  void loadDummyData() {
    _cartItems.addAll([
      CartItem(
        id: 1,
        name: 'Beige Shirt',
        price: 2500,
        imageUrl: 'assets/costume.png',
      ),
      CartItem(
        id: 2,
        name: 'Black Dress',
        price: 3500,
        imageUrl: 'assets/costume.png',
      ),
    ]);
    _calculateTotal();
    notifyListeners();
  }
}
