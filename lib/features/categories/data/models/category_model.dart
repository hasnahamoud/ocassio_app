
import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required String id,
    required String title,
    required String image,
  }) : super(id: id, title: title, image: image);

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      title: map['title'],
      image: map['image'],
    );
  }
}
