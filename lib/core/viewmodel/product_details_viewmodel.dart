import 'base_viewmodel.dart';

class ProductDetailsViewModel extends BaseViewModel {
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void addToCart() {
    // TODO: Implement add to cart functionality
  }

  void onNavItemTapped(int index) {
    setState(ViewState.busy);
    // TODO: Implement navigation
    setState(ViewState.idle);
  }
} 