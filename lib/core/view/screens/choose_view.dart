import 'package:flutter/material.dart';

class ChooseView extends StatelessWidget {
  const ChooseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login', arguments: {'role': 'user'});
              },
              child: const Text('User'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login', arguments: {'role': 'carrier'});
              },
              child: const Text('Carrier'),
            ),
          ],
        ),
      ),
    );
  }
}
