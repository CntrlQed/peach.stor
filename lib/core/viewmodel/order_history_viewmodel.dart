import 'package:flutter/material.dart';
import 'base_viewmodel.dart';

enum OrderStatus {
  placed,
  confirmed,
  shipped,
  delivered;

  String get label {
    switch (this) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.placed:
        return Colors.blue;
      case OrderStatus.confirmed:
        return Colors.orange;
      case OrderStatus.shipped:
        return Colors.purple;
      case OrderStatus.delivered:
        return Colors.green;
    }
  }
}

class OrderItem {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}

class Order {
  final String id;
  final String date;
  final List<OrderItem> items;
  final double totalAmount;
  final OrderStatus status;

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.totalAmount,
    required this.status,
  });

  void onTrackOrder() {
    // TODO: Implement order tracking
    print('Tracking order: $id');
  }

  void onReorder() {
    // TODO: Implement reorder functionality
    print('Reordering: $id');
  }
}

class OrderHistoryViewModel extends BaseViewModel {
  bool _isLoading = false;
  final List<Order> _orders = [];

  bool get isLoading => _isLoading;
  List<Order> get orders => _orders;

  OrderHistoryViewModel() {
    _loadOrders();
  }

  void _loadOrders() {
    _isLoading = true;
    notifyListeners();

    // Simulating API call
    Future.delayed(const Duration(milliseconds: 500), () {
      _orders.addAll([
        Order(
          id: 'OD123456',
          date: '15 Feb 2024',
          items: [
            OrderItem(
              id: 1,
              name: 'Beige Shirt',
              price: 2500,
              imageUrl: 'assets/costume.png',
              quantity: 1,
            ),
            OrderItem(
              id: 2,
              name: 'Black Dress',
              price: 3500,
              imageUrl: 'assets/costume.png',
              quantity: 1,
            ),
          ],
          totalAmount: 6000,
          status: OrderStatus.delivered,
        ),
        Order(
          id: 'OD123457',
          date: '18 Feb 2024',
          items: [
            OrderItem(
              id: 3,
              name: 'Blue Jeans',
              price: 1800,
              imageUrl: 'assets/costume.png',
              quantity: 2,
            ),
          ],
          totalAmount: 3600,
          status: OrderStatus.shipped,
        ),
        Order(
          id: 'OD123458',
          date: '20 Feb 2024',
          items: [
            OrderItem(
              id: 4,
              name: 'Silver Necklace',
              price: 1200,
              imageUrl: 'assets/costume.png',
              quantity: 1,
            ),
            OrderItem(
              id: 5,
              name: 'Gold Ring',
              price: 2500,
              imageUrl: 'assets/costume.png',
              quantity: 1,
            ),
            OrderItem(
              id: 6,
              name: 'Diamond Earrings',
              price: 5000,
              imageUrl: 'assets/costume.png',
              quantity: 1,
            ),
          ],
          totalAmount: 8700,
          status: OrderStatus.confirmed,
        ),
      ]);

      _isLoading = false;
      notifyListeners();
    });
  }

  void onOrderTapped(Order order) {
    // TODO: Navigate to order details
    print('Order tapped: ${order.id}');
  }

  void onNavItemTapped(int index, BuildContext context) {
    if (index != 3) {
      // If not orders tab
      setState(ViewState.busy);
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/categories');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/favorites');
          break;
        case 4:
          Navigator.pushReplacementNamed(context, '/profile');
          break;
      }
      setState(ViewState.idle);
    }
  }
}
