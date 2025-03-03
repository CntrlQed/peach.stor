import 'package:flutter/material.dart';
import '../../viewmodel/base_viewmodel.dart';
import '../../viewmodel/splash_viewmodel.dart';
import '../base_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      onModelReady: (model) => model.checkAuthAndNavigate(context),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or app name
              const Text(
                'Peach Store',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Loading indicator
              if (model.state == ViewState.busy)
                const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
