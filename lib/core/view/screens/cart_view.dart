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
          title: 'My Cart',
          showBackButton: true,
          showBottomNav: false,
          backgroundColor: AppColors.background,
          body: model.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: model.cartItems.isEmpty
                          ? _buildEmptyCart(context)
                          : _buildCartList(model),
                    ),
                    _buildCouponSection(),
                    _buildPaymentDetails(model),
                    _buildCheckoutButton(),
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

  Widget _buildCouponSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Coupons for you', style: AppStyles.heading2),
          const SizedBox(height: 8),
          ElevatedButton(
            style: AppStyles.primaryButton,
            onPressed: () {},
            child: const Text('Apply Coupons'),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(CartViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment details', style: AppStyles.heading2),
          const SizedBox(height: 8),
          _buildPaymentRow('Subtotal', '${AppStrings.price}${model.totalAmount}'),
          _buildPaymentRow('Discount', '₹0'),
          _buildPaymentRow('Shipping', 'To be calculated at the checkout'),
          _buildPaymentRow('Grand Total', '${AppStrings.price}${model.totalAmount}'),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppStyles.body1),
          Text(value, style: AppStyles.body1),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: AppStyles.primaryButton,
        onPressed: () {},
        child: const Text('CHECKOUT'),
      ),
    );
  }
}
