import '../../../cart/domain/entities/cart_item.dart';

abstract class CheckoutEvent {}

class PlaceOrder extends CheckoutEvent {
  final List<CartItem> items;
  final double totalAmount;
  final String paymentMethod;

  PlaceOrder({
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
  });
}
