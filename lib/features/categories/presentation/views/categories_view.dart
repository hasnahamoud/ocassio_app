
import 'package:flutter/material.dart';
import 'package:ocassio_app/features/categories/data/models/category_model.dart';
import 'package:ocassio_app/features/categories/presentation/widgets/categories_view_body.dart';
import 'package:ocassio_app/features/categories/presentation/widgets/custom_bottom_bar.dart';
import 'package:ocassio_app/features/login/presentation/widgets/customBottomAppBar.dart';

import '../../domain/entities/category.dart';
import '../widgets/category_item.dart';
class CategoriesView extends StatelessWidget {
  final List<Category>? categories;
  final Function(Category)? onCategorySelected;

  const CategoriesView({
    Key? key,
    this.categories,
    this.onCategorySelected,
  }) : super(key: key);
  static String id = 'CategoriesView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdeb3ad),
      body: CategoriesViewBody(categories: [  CategoryModel(id: 'c0', title: 'Graduation', image: 'assets/images/hasna1.jpg'),
      CategoryModel(id: 'c4', title: 'Reveal', image: 'assets/images/hasna.jpg'),
      CategoryModel(id: 'c2', title: 'Birthday', image: 'assets/images/hasna2.jpg'),
      CategoryModel(id: 'c3', title: 'Wedding', image: 'assets/images/hasna3.jpg'),
      CategoryModel(id: 'c1', title: 'Al-Hajj', image: 'assets/images/photo_٢٠٢٥-٠٨-٣١_١٦-٠٤-٥٢.jpg')],),
bottomNavigationBar: Custombottomappbar(),
    );
  }
}
