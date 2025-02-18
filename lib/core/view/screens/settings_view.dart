import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../viewmodel/settings_viewmodel.dart';
import '../widgets/base_page.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsViewModel>(
      create: (context) => SettingsViewModel(),
      child: Consumer<SettingsViewModel>(
        builder: (context, model, child) => BasePage(
          title: 'Settings',
          showBackButton: true,
          showBottomNav: false,
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSection(
                title: 'Account',
                children: [
                  _buildSettingsTile(
                    icon: Icons.person_outline,
                    title: 'Profile Information',
                    onTap: model.onProfileTapped,
                  ),
                  _buildSettingsTile(
                    icon: Icons.location_on_outlined,
                    title: 'Addresses',
                    onTap: model.onAddressesTapped,
                  ),
                  _buildSettingsTile(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    onTap: model.onPaymentMethodsTapped,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                title: 'Preferences',
                children: [
                  _buildSwitchTile(
                    icon: Icons.notifications_outlined,
                    title: 'Push Notifications',
                    value: model.pushNotificationsEnabled,
                    onChanged: model.setPushNotifications,
                  ),
                  _buildSwitchTile(
                    icon: Icons.email_outlined,
                    title: 'Email Notifications',
                    value: model.emailNotificationsEnabled,
                    onChanged: model.setEmailNotifications,
                  ),
                  _buildSwitchTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    value: model.darkModeEnabled,
                    onChanged: model.setDarkMode,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                title: 'Security',
                children: [
                  _buildSwitchTile(
                    icon: Icons.fingerprint,
                    title: 'Biometric Authentication',
                    value: model.biometricEnabled,
                    onChanged: model.setBiometric,
                  ),
                  _buildSettingsTile(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: model.onChangePasswordTapped,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                title: 'About',
                children: [
                  _buildSettingsTile(
                    icon: Icons.info_outline,
                    title: 'App Version',
                    subtitle: model.appVersion,
                    showArrow: false,
                  ),
                  _buildSettingsTile(
                    icon: Icons.description_outlined,
                    title: 'Terms of Service',
                    onTap: model.onTermsTapped,
                  ),
                  _buildSettingsTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: model.onPrivacyTapped,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildLogoutButton(model),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.heading2,
        ),
        const SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    bool showArrow = true,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppStyles.body1),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppStyles.body2.copyWith(color: AppColors.textLight),
            )
          : null,
      trailing: showArrow
          ? const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textLight,
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppStyles.body1),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
    );
  }

  Widget _buildLogoutButton(SettingsViewModel model) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: model.onLogoutTapped,
      child: Text(
        'Logout',
        style: AppStyles.body1.copyWith(
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
