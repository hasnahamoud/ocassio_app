import '../models/category_model.dart';

class CategoriesLocalDataSource {
  final List<CategoryModel> _categories = [
    CategoryModel(id: 'c0', title: 'Graduation', image: 'assets/images/hasna1.jpg'),
    CategoryModel(id: 'c1', title: 'Reveal', image: 'assets/images/hasna.jpg'),
    CategoryModel(id: 'c2', title: 'Birthday', image: 'assets/images/hasna2.jpg'),
    CategoryModel(id: 'c3', title: 'Wedding', image: 'assets/images/hasna3.jpg'),
  CategoryModel(id: 'c4', title: 'Al_Hajj', image:'assets/images/photo_٢٠٢٥-٠٨-٣١_١٦-٠٤-٥٢.jpg')];

  Future<List<CategoryModel>> getCategories() async {
    return _categories;
  }
}
