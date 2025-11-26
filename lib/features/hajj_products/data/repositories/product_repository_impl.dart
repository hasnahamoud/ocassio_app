

import '../../../hajj_products/domain/repositories/product_repository.dart';
import '../../../hajj_products/domain/product.dart';
import '../data_sources/hajj_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final HajjRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProductsByCategory(String categoryId, {String? type}) async {
    return await remoteDataSource.fetchProductsByCategory(categoryId, type: type);
  }
  @override
  Future<List<Product>> searchProducts(String query) async {
    return await remoteDataSource.searchProducts(query);
  }
}
