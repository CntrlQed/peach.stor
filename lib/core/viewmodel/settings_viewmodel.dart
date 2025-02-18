import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  // Notification settings
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = true;

  // Theme settings
  bool _darkModeEnabled = false;

  // Security settings
  bool _biometricEnabled = false;

  // App info
  final String _appVersion = '1.0.0';

  // Getters
  bool get pushNotificationsEnabled => _pushNotificationsEnabled;
  bool get emailNotificationsEnabled => _emailNotificationsEnabled;
  bool get darkModeEnabled => _darkModeEnabled;
  bool get biometricEnabled => _biometricEnabled;
  String get appVersion => _appVersion;

  // Setters with notifications
  void setPushNotifications(bool value) {
    _pushNotificationsEnabled = value;
    notifyListeners();
    // TODO: Save to persistent storage
  }

  void setEmailNotifications(bool value) {
    _emailNotificationsEnabled = value;
    notifyListeners();
    // TODO: Save to persistent storage
  }

  void setDarkMode(bool value) {
    _darkModeEnabled = value;
    notifyListeners();
    // TODO: Save to persistent storage and update app theme
  }

  void setBiometric(bool value) {
    _biometricEnabled = value;
    notifyListeners();
    // TODO: Save to persistent storage and setup biometric
  }

  // Navigation handlers
  void onProfileTapped() {
    // TODO: Navigate to profile page
    print('Navigate to profile');
  }

  void onAddressesTapped() {
    // TODO: Navigate to addresses page
    print('Navigate to addresses');
  }

  void onPaymentMethodsTapped() {
    // TODO: Navigate to payment methods page
    print('Navigate to payment methods');
  }

  void onChangePasswordTapped() {
    // TODO: Navigate to change password page
    print('Navigate to change password');
  }

  void onTermsTapped() {
    // TODO: Navigate to terms page
    print('Navigate to terms');
  }

  void onPrivacyTapped() {
    // TODO: Navigate to privacy policy page
    print('Navigate to privacy policy');
  }

  void onLogoutTapped() {
    // TODO: Implement logout logic
    print('Logout tapped');
  }
}
