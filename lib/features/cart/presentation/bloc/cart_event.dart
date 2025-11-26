import '../../domain/entities/cart_item.dart';

abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final CartItem item;
  AddItemToCart(this.item);
}

class RemoveItemFromCart extends CartEvent {
  final String productId;
  RemoveItemFromCart(this.productId);
}

class UpdateItemQuantity extends CartEvent {
  final String productId;
  final int quantity;
  UpdateItemQuantity(this.productId, this.quantity);
}

class GetCartItems extends CartEvent {}

class ClearCart extends CartEvent {}
