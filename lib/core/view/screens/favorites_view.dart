import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/favorites_viewmodel.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesViewModel>(
      create: (context) => FavoritesViewModel(),
      child: Consumer<FavoritesViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: const Text(
              'FAVOURITES',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
          body: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 4, // Number of favorite items
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Product Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/costume.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  // Heart Icon
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: 2, // Favorites tab
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
} 