abstract class ProductsEvent {}

class LoadGraduationProducts extends ProductsEvent {
  final String categoryId;
  final String? type; // <--- تم إضافة هذا الباراميتر

  LoadGraduationProducts(this.categoryId, {this.type}); // <--- تم تعديل الـ Constructor
}
class SearchProducts extends ProductsEvent {
  final String query;
  SearchProducts(this.query);
}