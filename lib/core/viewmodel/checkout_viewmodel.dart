import 'package:flutter/material.dart';

enum PaymentMethod {
  creditCard,
  digitalWallet,
  cashOnDelivery,
}

class CheckoutViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentStep = 0;
  PaymentMethod? _selectedPaymentMethod;

  // Address form fields
  String _fullName = '';
  String _addressLine1 = '';
  String _addressLine2 = '';
  String _city = '';
  String _postalCode = '';

  int get currentStep => _currentStep;
  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;

  String get formattedAddress {
    final List<String> parts = [
      _fullName,
      _addressLine1,
      if (_addressLine2.isNotEmpty) _addressLine2,
      _city,
      _postalCode,
    ];
    return parts.where((part) => part.isNotEmpty).join(', ');
  }

  String get formattedPaymentMethod {
    switch (_selectedPaymentMethod) {
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.digitalWallet:
        return 'Digital Wallet';
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
      default:
        return 'Not selected';
    }
  }

  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void setFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  void setAddressLine1(String value) {
    _addressLine1 = value;
    notifyListeners();
  }

  void setAddressLine2(String value) {
    _addressLine2 = value;
    notifyListeners();
  }

  void setCity(String value) {
    _city = value;
    notifyListeners();
  }

  void setPostalCode(String value) {
    _postalCode = value;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void placeOrder(BuildContext context) {
    // TODO: Implement order placement logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Placed'),
        content: const Text('Your order has been placed successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
