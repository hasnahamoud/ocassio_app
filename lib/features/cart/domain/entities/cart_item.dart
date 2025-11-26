// lib/features/cart/domain/entities/cart_item.dart
import '../../../product_details/domain/entities/product_detail.dart';

class CartItem {
  final ProductDetail product;
  final int quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({
    ProductDetail? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  // 💡 التعديل هنا: يجب أن يكون 'productId' وليس أي شيء آخر
  Map<String, dynamic> toJson() {
    return {
      'productId': product.id,
      'name': product.name,
      'quantity': quantity,
      'price': product.price,
      'image': product.image,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    // 💡 التعديل هنا ليتوافق مع التعديل أعلاه
    return CartItem(
      product: ProductDetail(
        id: json['productId'] as String,
        name: json['name'] as String,
        price: (json['price'] as num).toDouble(),
        image:  json['image'] as String,
        description: '',
      ),
      quantity: json['quantity'] as int,
    );
  }
}