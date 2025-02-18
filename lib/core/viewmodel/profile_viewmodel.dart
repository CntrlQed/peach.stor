// ignore: unused_import
import 'package:flutter/material.dart';
import 'base_viewmodel.dart';

class ProfileViewModel extends BaseViewModel {
  void logout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Implement actual logout
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onNavItemTapped(int index, BuildContext context) {
    if (index != 4) {
      // If not profile tab
      setState(ViewState.busy);
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/categories');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/favorites');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/orders');
          break;
      }
      setState(ViewState.idle);
    }
  }

  void onEditProfileTapped(BuildContext context) {
    // TODO: Navigate to edit profile
    print('Navigate to edit profile');
  }

  void onAddressesTapped(BuildContext context) {
    // TODO: Navigate to addresses
    print('Navigate to addresses');
  }

  void onOrdersTapped(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/orders');
  }

  void onPaymentMethodsTapped(BuildContext context) {
    // TODO: Navigate to payment methods
    print('Navigate to payment methods');
  }

  void onLogoutTapped(BuildContext context) {
    // TODO: Implement logout
    print('Logout tapped');
  }
}
