abstract class ProductsEvent {}

class LoadRevealProducts extends ProductsEvent {
  final String categoryId;
  final String? type; // <--- تم إضافة هذا الباراميتر

  LoadRevealProducts(this.categoryId, {this.type}); // <--- تم تعديل الـ Constructor
}
class SearchProducts extends ProductsEvent {
  final String query;
  SearchProducts(this.query);
}