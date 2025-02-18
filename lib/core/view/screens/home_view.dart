import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../../view/screens/notification_view.dart';
import '../widgets/base_page.dart';
import '../../constants/app_constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => BasePage(
          showBottomNav: true,
          currentIndex: model.currentIndex,
          onNavTap: (index) => model.setIndex(index, context),
          customAppBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AppAssets.peachIcon),
            ),
            actions: [
              IconButton(
                icon: Image.asset(AppAssets.notificationIcon),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationView()),
                  );
                },
              ),
              IconButton(
                icon: Image.asset(AppAssets.shoppingBagIcon),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Main Ad Image
                // Image.asset(
                //   AppAssets.homeAd,
                //   width: double.infinity,
                //   height: 200,
                //   fit: BoxFit.cover,
                // ),
                const SizedBox(height: 20),

                // Dot indicators
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: List.generate(
                //     4,
                //     (index) => Container(
                //       margin: const EdgeInsets.symmetric(horizontal: 4),
                //       width: 8,
                //       height: 8,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: index == 0
                //             ? AppColors.primary
                //             : AppColors.textLight,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20),

                // Products Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => model.onProductTapped(
                        context,
                        Product(
                          id: index,
                          name: 'Beige Shirt',
                          description:
                              'A comfortable beige shirt for casual wear',
                          price: 2500,
                          imageUrl: AppAssets.costume,
                          category: 'Shirts',
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  AppAssets.costume,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Beige Shirt',
                                  style: AppStyles.body1.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${AppStrings.price}2500',
                                  style: AppStyles.body1.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
