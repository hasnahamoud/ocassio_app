import '../../domain/entities/cart_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double totalPrice;

  CartLoaded(this.items)
      : totalPrice = items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
