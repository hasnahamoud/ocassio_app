// lib/features/birthday_products/presentation/widgets/search_results_view.dart

import 'package:flutter/material.dart';
import '../../domain/product.dart';
import '../../../product_details/presentation/views/product_view.dart';
import '../../../product_details/domain/entities/product_detail.dart';
import 'products_section.dart'; // يمكن إعادة استخدام نفس تصميم البطاقة

class SearchResultsView extends StatelessWidget {
  final List<Product> products;

  const SearchResultsView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No results found.'));
    }

    // 💡 يمكن استخدام GridView أو ListView لعرض النتائج
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // لمنع التمرير المزدوج
      shrinkWrap: true, // لتكييف الارتفاع مع المحتوى
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailsView.id,
              arguments: ProductDetail(
                id: product.id,
                name: product.title,
                price: product.price,
                image: product.image,
                description: product.descripion,
              ),
            );
          },
          child: Container(
            // 💡 إعادة استخدام تصميم بطاقة المنتج
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    product.image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.brown,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "\$${product.price.toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}