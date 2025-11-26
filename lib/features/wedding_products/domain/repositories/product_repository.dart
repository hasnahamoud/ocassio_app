
import 'package:ocassio_app/features/wedding_products/domain/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductsByCategory(String categoryId, {String? type});
  Future<List<Product>> searchProducts(String query);
}
