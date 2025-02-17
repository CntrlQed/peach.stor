import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/starting_viewmodel.dart';
import 'choose_view.dart';

class StartingView extends StatelessWidget {
  const StartingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StartingViewModel>(
      create: (context) => StartingViewModel(),
      child: Consumer<StartingViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Background Image
              Image.asset(
                'assets/starting.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              // Content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ChooseView()),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'GET STARTED',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'By continuing you agree to our Terms and Conditions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 