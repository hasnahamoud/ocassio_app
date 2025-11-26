

import 'package:ocassio_app/features/wedding_products/domain/product.dart';
import 'package:ocassio_app/features/wedding_products/domain/repositories/product_repository.dart';

import '../data_sources/wedding_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final WeddingRemoteDataSource remoteDataSource;

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
