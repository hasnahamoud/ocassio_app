import '../../domain/entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItem> _cartItems = [];

  @override
  Future<void> addToCart(CartItem item) async {
    final existingItemIndex = _cartItems.indexWhere((i) => i.product.id == item.product.id);
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex] = _cartItems[existingItemIndex].copyWith(
        quantity: _cartItems[existingItemIndex].quantity + item.quantity,
      );
    } else {
      _cartItems.add(item);
    }
  }

  @override
  Future<void> removeFromCart(String productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
  }

  @override
  Future<void> updateItemQuantity(String productId, int quantity) async {
    final existingItemIndex = _cartItems.indexWhere((i) => i.product.id == productId);
    if (existingItemIndex != -1) {
      if (quantity > 0) {
        _cartItems[existingItemIndex] = _cartItems[existingItemIndex].copyWith(quantity: quantity);
      } else {
        _cartItems.removeAt(existingItemIndex);
      }
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    return List.from(_cartItems);
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
  }
}
