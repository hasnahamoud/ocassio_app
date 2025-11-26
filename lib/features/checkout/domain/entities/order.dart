
import '../../../cart/domain/entities/cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final String paymentMethod;
  final String status;
  final DateTime orderDate;

  const Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    required this.orderDate,
  });
}
