import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../viewmodel/profile_viewmodel.dart';
import '../../view/widgets/base_page.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>.value(
      value: _viewModel,
      child: Consumer<ProfileViewModel>(
        builder: (context, model, child) => BasePage(
          showBottomNav: true,
          currentIndex: 4,
          onNavTap: (index) => model.onNavItemTapped(index, context),
          backgroundColor: Colors.black,
          customAppBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AppAssets.peachIcon),
            ),
            actions: [
              IconButton(
                icon: Image.asset(AppAssets.notificationIcon),
                onPressed: () => Navigator.pushNamed(context, '/notifications'),
              ),
              IconButton(
                icon: Image.asset(AppAssets.shoppingBagIcon),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 20),
              // Profile Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => model.onEditProfileTapped(context),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: model.user?.profilePicture != null
                            ? NetworkImage(model.user!.profilePicture!)
                            : null,
                        child: model.user?.profilePicture == null
                            ? Text(
                                model.user?.name.substring(0, 2).toUpperCase() ??
                                    'NA',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello ${model.user?.name ?? "User"}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          model.user?.email ?? 'No email',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () => model.onEditProfileTapped(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Menu Items
              _buildMenuItem(
                'Address Book',
                'View all saved addresses',
                Icons.home_outlined,
                onTap: () => Navigator.pushNamed(context, '/addresses'),
              ),
              _buildMenuItem(
                'Order History',
                'View all past orders',
                Icons.history,
                onTap: () => Navigator.pushNamed(context, '/order-history'),
              ),
              _buildMenuItem(
                'Change Password',
                'Edit your password',
                Icons.lock_outline,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              // Footer Links
              _buildFooterLink('Privacy Policy'),
              _buildFooterLink('Terms and Service'),
              _buildFooterLink('Return/Exchange'),
              _buildFooterLink('Contact Us'),
              const SizedBox(height: 20),
              // Logout Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OutlinedButton(
                  onPressed: () => model.logout(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, String subtitle, IconData icon,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
