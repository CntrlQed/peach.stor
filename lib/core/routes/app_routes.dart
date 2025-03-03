import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/user_model.dart';
import '../view/screens/cart_view.dart';
import '../view/screens/categories_view.dart';
import '../view/screens/checkout_view.dart';
import '../view/screens/edit_profile_view.dart';
import '../view/screens/favorites_view.dart';
import '../view/screens/home_view.dart';
import '../view/screens/login_view.dart';
import '../view/screens/notification_view.dart';
import '../view/screens/order_history_view.dart';
import '../view/screens/product_details_view.dart';
import '../view/screens/profile_view.dart';
import '../view/screens/search_view.dart';
import '../view/screens/settings_view.dart';
import '../view/screens/signup_view.dart';
import '../view/screens/splash_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String favorites = '/favorites';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String search = '/search';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String orderHistory = '/order-history';
  static const String orders = '/orders';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    if (name == splash) {
      return MaterialPageRoute(builder: (_) => const SplashView());
    } else if (name == home) {
      return MaterialPageRoute(builder: (_) => const HomeView());
    } else if (name == categories) {
      return MaterialPageRoute(builder: (_) => const CategoriesView());
    } else if (name == productDetails) {
      final args = settings.arguments as Map<String, dynamic>?;
      if (args == null || args['product'] == null) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Product not found'),
            ),
          ),
        );
      }
      return MaterialPageRoute(
        builder: (_) => ProductDetailsView(product: args['product'] as Product),
      );
    } else if (name == cart) {
      return MaterialPageRoute(builder: (_) => const CartView());
    } else if (name == checkout) {
      return MaterialPageRoute(builder: (_) => const CheckoutView());
    } else if (name == favorites) {
      return MaterialPageRoute(builder: (_) => const FavoritesView());
    } else if (name == login) {
      return MaterialPageRoute(builder: (_) => const LoginView());
    } else if (name == signup) {
      return MaterialPageRoute(builder: (_) => const SignUpView());
    } else if (name == profile) {
      return MaterialPageRoute(builder: (_) => const ProfileView());
    } else if (name == editProfile) {
      final args = settings.arguments as Map<String, dynamic>?;
      final mockUser = User(
        name: 'Noora Sajil',
        email: 'noorasajil@gmail.com',
      );
      final user = args?['user'] as User? ?? mockUser;
      final onSave = args?['onSave'] as Future<void> Function(String, String, String?)? ?? 
        ((_, __, ___) async => null);
      
      return MaterialPageRoute(
        builder: (_) => EditProfileView(
          user: user,
          onSave: onSave,
        ),
      );
    } else if (name == search) {
      return MaterialPageRoute(builder: (_) => const SearchView());
    } else if (name == settings) {
      return MaterialPageRoute(builder: (_) => const SettingsView());
    } else if (name == notifications) {
      return MaterialPageRoute(builder: (_) => const NotificationView());
    } else if (name == orderHistory || name == orders) {
      return MaterialPageRoute(builder: (_) => const OrderHistoryView());
    } else {
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
    }
  }
} 