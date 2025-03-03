// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'base_viewmodel.dart';

class ProfileViewModel extends BaseViewModel {
  static const String _userKey = 'user_profile';
  final _authService = AuthService();
  User? _user;
  User? get user => _user;

  ProfileViewModel() {
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    setState(ViewState.busy);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        _user = User.fromJsonString(userJson);
      } else {
        // Default user data if none exists
        _user = User(
          name: 'Noora',
          email: 'noorasaji@gmail.com',
        );
        await _saveUserData(); // Save default data
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    } finally {
      setState(ViewState.idle);
    }
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserData() async {
    if (_user == null) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, _user!.toJsonString());
    } catch (e) {
      debugPrint('Error saving user data: $e');
      rethrow;
    }
  }

  // Update user profile
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? profilePicture,
  }) async {
    setState(ViewState.busy);
    try {
      if (_user != null) {
        _user = _user!.copyWith(
          name: name,
          email: email,
          phone: phone,
          profilePicture: profilePicture,
        );
        await _saveUserData();
      }
    } catch (e) {
      debugPrint('Error updating profile: $e');
      rethrow;
    } finally {
      setState(ViewState.idle);
    }
  }

  void logout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
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
                    onPressed: () => Navigator.of(context).pop(),
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
                    onPressed: () async {
                      Navigator.of(context).pop();
                      setState(ViewState.busy);
                      try {
                        await _authService.signOut();
                        if (context.mounted) {
                          await Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        }
                      } catch (e) {
                        debugPrint('Error during logout: $e');
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error logging out. Please try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } finally {
                        setState(ViewState.idle);
                      }
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

  Future<void> onNavItemTapped(int index, BuildContext context) async {
    if (index != 4) {
      setState(ViewState.busy);
      try {
        switch (index) {
          case 0:
            await Navigator.pushNamed(context, '/home');
            break;
          case 1:
            await Navigator.pushNamed(context, '/categories');
            break;
          case 2:
            await Navigator.pushNamed(context, '/favorites');
            break;
          case 3:
            await Navigator.pushNamed(context, '/orders');
            break;
        }
      } catch (e) {
        debugPrint('Error navigating: $e');
      } finally {
        setState(ViewState.idle);
      }
    }
  }

  Future<void> onEditProfileTapped(BuildContext context) async {
    try {
      if (_user == null) {
        _user = User(
          name: 'Noora Sajil',
          email: 'noorasajil@gmail.com',
        );
        await _saveUserData();
      }
      
      await Navigator.pushNamed(
        context,
        '/edit-profile',
        arguments: {
          'user': _user,
          'onSave': (String name, String email, String? phone) async {
            await updateProfile(
              name: name,
              email: email,
              phone: phone,
            );
          },
        },
      );
      await _loadUserData(); // Refresh data after returning
    } catch (e) {
      debugPrint('Error navigating to edit profile: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error opening edit profile. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
