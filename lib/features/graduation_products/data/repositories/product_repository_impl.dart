


import 'package:ocassio_app/features/graduation_products/domain/product.dart';
import 'package:ocassio_app/features/graduation_products/domain/repositories/product_repository.dart';

import '../data_sources/graduation_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final GraduationRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProductsByCategory(String categoryId, {String? type}) async {
    // تمرير الـ type إلى الـ remoteDataSource
    return await remoteDataSource.fetchProductsByCategory(categoryId, type: type);
  }
  // 💡 تطبيق دالة البحث
  @override
  Future<List<Product>> searchProducts(String query) async {
    return await remoteDataSource.searchProducts(query);
  }
}
