import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../viewmodel/order_history_viewmodel.dart';
import '../widgets/base_page.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderHistoryViewModel>(
      create: (context) => OrderHistoryViewModel(),
      child: Consumer<OrderHistoryViewModel>(
        builder: (context, model, child) => BasePage(
          title: 'My Orders',
          showBottomNav: true,
          currentIndex: 3,
          onNavTap: (index) => model.onNavItemTapped(index, context),
          body: model.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : model.orders.isEmpty
                  ? _buildEmptyState()
                  : _buildOrderList(model),
          backgroundColor: Colors.black,
          customAppBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                AppAssets.peachIcon,
                height: 40,
                width: 40,
              ),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: Image.asset(AppAssets.notificationIcon, height: 24),
                    onPressed: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Image.asset(AppAssets.shoppingBagIcon, height: 24),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            'No Orders Yet',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 8),
          Text(
            'Start shopping to see your orders here',
            style: AppStyles.body2.copyWith(color: AppColors.textLight),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(OrderHistoryViewModel model) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: model.orders.length,
      itemBuilder: (context, index) {
        final order = model.orders[index];
        return AnimatedSlide(
          duration: AppAnimations.medium,
          offset: Offset.zero,
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () => model.onOrderTapped(order),
              borderRadius: BorderRadius.circular(12),
              child: Column(
                children: [
                  _buildOrderHeader(order),
                  _buildOrderItems(order),
                  _buildOrderProgress(order),
                  _buildOrderFooter(order),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderHeader(Order order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order #${order.id}',
                style: AppStyles.body1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                order.date,
                style: AppStyles.caption.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: order.status.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              order.status.label,
              style: AppStyles.caption.copyWith(
                color: order.status.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems(Order order) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Stack(
            children: [
              ...order.items.take(3).map((item) => Container(
                    margin: EdgeInsets.only(
                      left: order.items.indexOf(item) * 20.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.secondary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        item.imageUrl,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              if (order.items.length > 3)
                Container(
                  margin: const EdgeInsets.only(left: 60),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '+${order.items.length - 3}',
                      style: AppStyles.caption.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${order.items.length} items',
                  style: AppStyles.body2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${AppStrings.price}${order.totalAmount}',
                  style: AppStyles.body2.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderProgress(Order order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ...OrderStatus.values.map((status) {
            final isCompleted = status.index <= order.status.index;
            final isActive = status.index == order.status.index;
            return Expanded(
              child: Row(
                children: [
                  _buildStatusDot(isCompleted, isActive),
                  if (status != OrderStatus.values.last)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isCompleted
                            ? AppColors.primary
                            : AppColors.textLight.withOpacity(0.2),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatusDot(bool isCompleted, bool isActive) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.primary
            : AppColors.textLight.withOpacity(0.2),
        shape: BoxShape.circle,
        border: isActive
            ? Border.all(
                color: AppColors.primary,
                width: 2,
              )
            : null,
      ),
      child: isCompleted
          ? const Icon(
              Icons.check,
              color: AppColors.secondary,
              size: 16,
            )
          : null,
    );
  }

  Widget _buildOrderFooter(Order order) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => order.onTrackOrder(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Track Order'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => order.onReorder(),
              style: AppStyles.primaryButton,
              child: const Text('Reorder'),
            ),
          ),
        ],
      ),
    );
  }
}
