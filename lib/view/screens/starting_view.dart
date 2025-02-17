import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/starting_viewmodel.dart';

class StartingView extends StatelessWidget {
  const StartingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StartingViewModel(),
      child: Consumer<StartingViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Background pattern
              Image.asset(
                'assets/starting.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => model.onGetStarted(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'GET STARTED',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'By continuing you agree to terms and conditions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 