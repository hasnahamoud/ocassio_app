import '../../domain/entities/product_detail.dart';

// نموذج البيانات الذي يستقبل الـ JSON من الـ API
class ProductDetailModel extends ProductDetail {
  const ProductDetailModel({
    required String id,
    required String name,
    required double price,
    required String image,
    required String description,
  }) : super(
    id: id,
    name: name,
    price: price,
    image: image,
    description: description,
  );

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    // التأكد من استخراج البيانات الصحيحة من الـ JSON
    // هذا يعتمد على كيفية تنظيم البيانات في الـ Backend
    return ProductDetailModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['photo'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'photo': image,
      'description': description,
    };
  }
}
