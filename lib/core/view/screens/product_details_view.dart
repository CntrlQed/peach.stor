import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/product_details_viewmodel.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductDetailsViewModel>(
      create: (context) => ProductDetailsViewModel(),
      child: Consumer<ProductDetailsViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
              label: const Text(
                'BACK',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            leadingWidth: 100,
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
              // Product Image Section
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/costume.png',
                      fit: BoxFit.cover,
                    ),
                    // Favorite Button
                    Positioned(
                      top: 20,
                      right: 20,
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
                    // Dot Indicators
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 0 ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Product Details Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'bennitta beige Midi dress for women',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '₹ 1,300',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.checkroom, color: Colors.white, size: 24),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'COLOR:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      'BEIGE',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(Icons.arrow_drop_down, color: Colors.white),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SIZE:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      'XL',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(Icons.arrow_drop_down, color: Colors.white),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'FLOWY MIDI SKIRT WITH ASYMMETRIC\nSILHOUETTE WITHOUT SLIT',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => model.addToCart(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'ADD TO CART',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: 0,
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