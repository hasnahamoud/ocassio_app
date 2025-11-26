import '../../domain/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String title,
    required double price,
    required String image,
    required String descripion,
  }) : super(
    id: id,
    title: title,
    price: price,
    image: image,
    descripion: descripion,
  );

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final id = (map['_id'] ?? map['id'] ?? '').toString();
    final title = (map['name'] ?? map['title'] ?? '').toString();
    final image =
    (map['photo'] ?? map['image'] ?? map['imageUrl'] ?? '').toString();

    // انتبهي: API راجعة فيها غلطة مطبعية "descripion"
    final descripion =
    (map['descripion'] ?? map['descripion'] ?? '').toString();

    double price = 0.0;
    final p = map['price'];
    if (p is num) {
      price = p.toDouble();
    } else if (p is String) {
      price = double.tryParse(p) ?? 0.0;
    }

    return ProductModel(
      id: id,
      title: title,
      price: price,
      image: image,
      descripion: descripion,
    );
  }
}
