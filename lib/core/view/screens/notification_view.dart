import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/notification_viewmodel.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationViewModel>(
      create: (context) => NotificationViewModel(),
      child: Consumer<NotificationViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Notification',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildNotificationCard(
                'Good morning! Get 20% Voucher',
                'Summer sale up to 20% off. Limited voucher.\nGet now!! 🔥',
                model,
              ),
              const SizedBox(height: 12),
              _buildNotificationCard(
                'Special offer just for you',
                'New Autumn Collection 30% off',
                model,
              ),
              const SizedBox(height: 12),
              _buildNotificationCard(
                'Holiday sale 50%',
                'Tap here to get 50% voucher.',
                model,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String title, String subtitle, NotificationViewModel model) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => model.onNotificationTapped(title),
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 