import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/models/product.dart';
import 'core/view/screens/cart_view.dart';
import 'core/view/screens/categories_view.dart';
import 'core/view/screens/checkout_view.dart';
import 'core/view/screens/favorites_view.dart';
import 'core/view/screens/home_view.dart';
import 'core/view/screens/order_history_view.dart';
import 'core/view/screens/product_details_view.dart';
import 'core/view/screens/profile_view.dart';
import 'core/view/screens/search_view.dart';
import 'core/view/screens/settings_view.dart';
import 'core/view/screens/splash_view.dart';
import 'core/viewmodel/cart_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartViewModel()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.secondary),
            titleTextStyle: TextStyle(
              color: AppColors.secondary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: AppStyles.primaryButton,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            labelStyle: const TextStyle(color: AppColors.textLight),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return _buildRoute(const SplashView());
            case '/home':
              return _buildRoute(const HomeView());
            case '/categories':
              return _buildRoute(const CategoriesView());
            case '/favorites':
              return _buildRoute(const FavoritesView());
            case '/orders':
              return _buildRoute(const OrderHistoryView());
            case '/profile':
              return _buildRoute(const ProfileView());
            case '/cart':
              return _buildRoute(const CartView());
            case '/checkout':
              return _buildRoute(const CheckoutView());
            case '/search':
              return _buildRoute(const SearchView());
            case '/settings':
              return _buildRoute(const SettingsView());
            case '/product-details':
              if (settings.arguments != null) {
                return _buildRoute(
                  ProductDetailsView(
                    product: settings.arguments as Product,
                  ),
                );
              }
              return _buildRoute(const HomeView());
            default:
              return _buildRoute(const HomeView());
          }
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.05, 0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: AppAnimations.medium,
    );
  }
}
