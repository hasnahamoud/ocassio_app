abstract class ProductsEvent {}

class LoadWeddingProducts extends ProductsEvent {
  final String categoryId;
  final String? type;

  LoadWeddingProducts(this.categoryId, {this.type});
}
class SearchProducts extends ProductsEvent {
  final String query;
  SearchProducts(this.query);
}