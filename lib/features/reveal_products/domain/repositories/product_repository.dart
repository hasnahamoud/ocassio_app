
import 'package:ocassio_app/features/reveal_products/domain/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductsByCategory(String categoryId, {String? type}); // <--- تم التعديل
  Future<List<Product>> searchProducts(String query);
}
