import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.black;
  static const Color secondary = Colors.white;
  static const Color background = Colors.white;
  static const Color surface = Colors.black;
  static const Color text = Colors.black;
  static const Color textLight = Colors.grey;
  static const Color error = Colors.red;
  static const Color success = Colors.green;
}

class AppStrings {
  // Navigation
  static const String home = 'Home';
  static const String categories = 'Categories';
  static const String favorites = 'Favorites';
  static const String orders = 'Orders';
  static const String profile = 'Profile';
  static const String back = 'BACK';

  // Product
  static const String addToCart = 'ADD TO CART';
  static const String color = 'COLOR:';
  static const String size = 'SIZE:';
  static const String price = '₹';

  // Common
  static const String appName = 'Peach Store';
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
}

class AppAssets {
  // Icons
  static const String homeIcon = 'assets/home.png';
  static const String diversityIcon = 'assets/diversity.png';
  static const String heartIcon = 'assets/heart.png';
  static const String deliveryIcon = 'assets/SuccessfulDelivery.png';
  static const String personIcon = 'assets/Person.png';
  static const String notificationIcon = 'assets/Notification.png';
  static const String shoppingBagIcon = 'assets/Shopping Bag.png';
  static const String peachIcon = 'assets/peach.png';
  static const String googleIcon = 'assets/google.png';

  // Images
  static const String homeAd = 'assets/home_Ad.png';
  static const String costume = 'assets/costume.png';
}

class AppStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    color: AppColors.text,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    color: AppColors.text,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textLight,
  );

  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.secondary,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondary,
    foregroundColor: AppColors.primary,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}
