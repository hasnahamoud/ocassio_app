import '../../../cart/domain/entities/cart_item.dart';
import '../entities/order.dart';

abstract class CheckoutRepository {
  Future<Order> createOrder({
    required List<CartItem> items,
    required double totalAmount,
    required String paymentMethod,
  });
}
