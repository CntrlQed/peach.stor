import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashViewModel(),
      child: Consumer<SplashViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Image.asset(
              'assets/peach.png',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
} 