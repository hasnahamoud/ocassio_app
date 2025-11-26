
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/wedding_products/domain/product.dart';
import 'package:ocassio_app/features/wedding_products/presentation/bloc/products_bloc.dart';
import 'package:ocassio_app/features/wedding_products/presentation/bloc/products_state.dart';

import '../../../product_details/domain/entities/product_detail.dart';
import '../../../product_details/presentation/views/product_view.dart';

class ProductsSection extends StatefulWidget {
  final String title;
  final String categoryId;
  const ProductsSection({
    super.key,
    required this.title,
    required this.categoryId,
  });

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height:2),
        Text(
          "${widget.title} :",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<ProductsBloc, ProductsState>(
          buildWhen: (previousState, currentState) {
            if (currentState is ProductsLoading && currentState.categoryId == widget.categoryId) return true;
            if (currentState is ProductsLoaded && currentState.categoryId == widget.categoryId) return true;
            if (currentState is ProductsFailure && currentState.categoryId == widget.categoryId) return true;
            if (previousState is ProductsInitial && currentState is! ProductsInitial) return true;
            return false;
          },
          builder: (context, state) {
            if (state is ProductsLoading && state.categoryId == widget.categoryId) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded && state.categoryId == widget.categoryId) {
              if (state.products.isEmpty) {
                return Center(
                  child: Text(
                    "No ${widget.title.toLowerCase()} found.",
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              }
              return SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    Product product = state.products[index];
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
                        height: 230,
                        width: 160,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
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
                            const SizedBox(height:10),
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
                            const SizedBox(height: 14),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
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
                ),
              );
            } else if (state is ProductsFailure && state.categoryId == widget.categoryId) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
