import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/peach.png'),
            ),
            actions: [
              IconButton(
                icon: Image.asset('assets/Notification.png'),
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset('assets/Shopping Bag.png'),
                onPressed: () {},
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
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[300],
                      child: const Text(
                        'NS',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hello Noora,',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'noorasaji@gmail.com',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
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
                onTap: () {},
              ),
              _buildMenuItem(
                'Order History',
                'View all past orders',
                Icons.history,
                onTap: () {},
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
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: 4,
            onTap: model.onNavItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/Home.png', height: 24),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/Diversity.png', height: 24),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/Heart.png', height: 24),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/SuccessfulDelivery.png', height: 24),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/Person.png', height: 24),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, String subtitle, IconData icon, {required VoidCallback onTap}) {
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
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
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