import 'package:flutter/material.dart';
import 'package:ocassio_app/features/categories/presentation/widgets/category_item.dart';
import '../../domain/entities/category.dart';

class CategoriesViewBody extends StatelessWidget {
  final List<Category>? categories;

  const CategoriesViewBody({
    Key? key,
    this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (categories == null || categories!.length < 5) {
      return const Center(child: Text('No categories to display.'));
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      height: double.infinity,
                      child: CategoryItem(
                        title: categories![0].title,
                        image: categories![0].image,
                        onTap: () {
                            Navigator.pushNamed(context, 'GraduationProductsView');

                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      height: double.infinity,
                      child: CategoryItem(
                        title: categories![4].title,
                        image: categories![4].image,
                        onTap: () {
                          Navigator.pushNamed(context, 'HajjProductsView');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      height: double.infinity,
                      child: CategoryItem(
                        title: categories![2].title,
                        image: categories![2].image,
                        onTap: () {
                          if (categories![2].id == 'c2') {
                            Navigator.pushNamed(context, 'BirthdayProductsView');

                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      height: double.infinity,
                      child: CategoryItem(
                        title: categories![3].title,
                        image: categories![3].image,
                        onTap: () {

                            Navigator.pushNamed(context,'WeddingProductsView');

                        },
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      height: double.infinity,
                      child: CategoryItem(
                        title: categories![1].title,
                        image: categories![1].image,
                        onTap: () {

                            Navigator.pushNamed(context, 'RevealProductsView');

                        },
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),


        ],
      ),
    );
  }
}