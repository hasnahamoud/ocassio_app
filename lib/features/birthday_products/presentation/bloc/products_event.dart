abstract class ProductsEvent {}

class LoadBirthdayProducts extends ProductsEvent {
  final String categoryId;
  final String? type; // <--- تم إضافة هذا الباراميتر

  LoadBirthdayProducts(this.categoryId, {this.type}); // <--- تم تعديل الـ Constructor
}
class SearchProducts extends ProductsEvent {
  final String query;
  SearchProducts(this.query);
}