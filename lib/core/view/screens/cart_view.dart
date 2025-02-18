import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../viewmodel/cart_viewmodel.dart';
import '../widgets/base_page.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartViewModel>(
      create: (context) => CartViewModel()..loadDummyData(),
      child: Consumer<CartViewModel>(
        builder: (context, model, child) => BasePage(
          title: 'Cart',
          showBackButton: true,
          showBottomNav: false,
          backgroundColor: AppColors.background,
          body: model.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary))
              : Column(
                  children: [
                    Expanded(
                      child: model.cartItems.isEmpty
                          ? _buildEmptyCart(context)
                          : _buildCartList(model),
                    ),
                    if (model.cartItems.isNotEmpty)
                      _buildCheckoutSection(model),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to start shopping',
            style: AppStyles.body2.copyWith(color: AppColors.textLight),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: AppStyles.primaryButton,
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(CartViewModel model) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: model.cartItems.length,
      itemBuilder: (context, index) {
        final item = model.cartItems[index];
        return Dismissible(
          key: Key(item.id.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) => model.removeItem(item.id),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.delete_outline,
              color: AppColors.secondary,
            ),
          ),
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: AppStyles.body1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${AppStrings.price}${item.price}',
                          style: AppStyles.body2,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildQuantityButton(
                              icon: Icons.remove,
                              onPressed: () => model.decrementQuantity(item.id),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              item.quantity.toString(),
                              style: AppStyles.body1,
                            ),
                            const SizedBox(width: 16),
                            _buildQuantityButton(
                              icon: Icons.add,
                              onPressed: () => model.incrementQuantity(item.id),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        icon: Icon(icon, size: 16, color: AppColors.secondary),
        onPressed: onPressed,
        constraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildCheckoutSection(CartViewModel model) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: AppStyles.body1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${AppStrings.price}${model.totalAmount}',
                  style: AppStyles.heading2,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: AppStyles.primaryButton,
              onPressed: () => model.proceedToCheckout(),
              child: const Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
