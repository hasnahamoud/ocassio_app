
/*import '../../../cart/domain/entities/cart_item.dart';
import '../../../product_details/domain/entities/product_detail.dart';
// إذا كان لديك CartItemModel
import '../../domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required String id,
    required List<CartItem> items,
    required double totalAmount,
    required String paymentMethod,
    required String status,
    required DateTime orderDate,
  }) : super(
    id: id,
    items: items,
    totalAmount: totalAmount,
    paymentMethod: paymentMethod,
    status: status,
    orderDate: orderDate,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<CartItem> items = (json['cart'] as List)
        .map((itemJson) => CartItemModel.fromJson(itemJson as Map<String, dynamic>))
        .toList();

    return OrderModel(
      id: json['_id'] as String,
      items: items,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      status: json['status'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList()  ,

      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'status': status,
    };
  }
}

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.product,
    required super.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductDetail(
        id: json['productId'] as String,
        name: json['name'] as String,
        price: (json['price'] as num).toDouble(),
        image: '',
        description: '',
      ),
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'productId': product.id,
      'quantity': quantity,
      'price': product.price,
      'name': product.name, // <--- إضافة اسم المنتج هنا
    };
  }
}
*/// lib/features/checkout/data/models/checkout_model.dart

import '../../../cart/domain/entities/cart_item.dart';
import '../../../product_details/domain/entities/product_detail.dart';
import '../../domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required String id,
    required List<CartItem> items,
    required double totalAmount,
    required String paymentMethod,
    required String status,
    required DateTime orderDate,
  }) : super(
    id: id,
    items: items,
    totalAmount: totalAmount,
    paymentMethod: paymentMethod,
    status: status,
    orderDate: orderDate,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<CartItem> items = (json['cart'] as List)
        .map((itemJson) => CartItemModel.fromJson(itemJson as Map<String, dynamic>))
        .toList();

    return OrderModel(
      // تصحيح اسم الحقل من '_id'
      id: json['_id'] as String,
      // تمرير القائمة المعدلة من الـ CartItemModel
      items: items,
      // تصحيح اسم الحقل من 'total'
      totalAmount: (json['total'] as num).toDouble(),
      // تصحيح اسم الحقل من 'methodPayment'
      paymentMethod: json['methodPayment'] as String,
      // إضافة قيمة افتراضية لتجنب خطأ Null في حالة عدم وجود الحقل
      status: json['status'] as String? ?? 'Confirmed',
      // تصحيح اسم الحقل من 'createdAt'
      orderDate: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'status': status,
    };
  }
}

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.product,
    required super.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductDetail(
        // استخدام حقل 'productId' من استجابة الخادم
        id: json['productId'] as String,
        // إضافة قيمة افتراضية لتجنب خطأ Null
        name: json['name'] as String? ?? 'Unknown Product',
        price: (json['price'] as num).toDouble(),
        // إضافة قيمة افتراضية لتجنب خطأ Null
        image: json['image'] as String? ?? '',
        // إضافة قيمة افتراضية لتجنب خطأ Null
        description: json['description'] as String? ?? '',
      ),
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'productId': product.id,
      'quantity': quantity,
      'price': product.price,
      'name': product.name,
      'image': product.image,
      'description': product.description,
    };
  }
}