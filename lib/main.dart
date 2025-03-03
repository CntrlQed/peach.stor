import 'package:flutter/material.dart';
import 'package:peach_store/core/view/screens/edit_profile_view.dart';
import 'package:peach_store/core/view/screens/order_history_view.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/view/screens/choose_view.dart';
import 'core/view/screens/home_view.dart';
import 'core/view/screens/login_view.dart';
import 'core/view/screens/map_view.dart';
import 'core/view/screens/signup_view.dart';
import 'core/view/screens/splash_view.dart';
import 'core/viewmodel/choose_viewmodel.dart';
import 'core/viewmodel/home_viewmodel.dart';
import 'core/viewmodel/login_viewmodel.dart';
import 'core/viewmodel/signup_viewmodel.dart';
import 'core/viewmodel/splash_viewmodel.dart';
import 'core/view/screens/categories_view.dart';
import 'core/view/screens/favorites_view.dart';
import 'core/view/screens/profile_view.dart';
import 'core/view/screens/cart_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
        ChangeNotifierProvider(create: (_) => ChooseViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: MaterialApp(
        title: 'Peach Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashView(),
          '/choose': (context) => const ChooseView(),
          '/login': (context) => const LoginView(),
          '/signup': (context) => const SignUpView(),
          '/home': (context) => const HomeView(),
          '/map': (context) => const MapView(),
          '/categories': (context) => const CategoriesView(),
          '/favorites': (context) => const FavoritesView(),
          '/orders': (context) => const OrderHistoryView(),
          '/profile': (context) => const ProfileView(),
          '/edit-profile': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return EditProfileView(
              user: args['user'],
              onSave: args['onSave'],
            );
          },
          '/cart': (context) => const CartView(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
} 
