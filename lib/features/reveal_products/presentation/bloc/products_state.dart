

import 'package:ocassio_app/features/reveal_products/domain/product.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {
  final String categoryId;
  ProductsLoading(this.categoryId);
}


class ProductsLoaded extends ProductsState {
  final String categoryId;
  final List<Product> products;

  ProductsLoaded(this.categoryId, this.products);
}


class ProductsFailure extends ProductsState {
  final String categoryId;
  final String message;
  ProductsFailure(this.categoryId,this.message);
}
