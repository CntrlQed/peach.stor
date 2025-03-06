import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/notification_viewmodel.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
        child: Text('Notification Screen'),
      ),
    );
  }
} 