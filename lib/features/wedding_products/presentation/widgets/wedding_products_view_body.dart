
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/wedding_products/presentation/bloc/products_event.dart';

import '../../../wedding_products/presentation/widgets/search_bar.dart';
import '../../../wedding_products/presentation/bloc/products_state.dart';
import '../../../wedding_products/domain/product.dart';
import '../../../wedding_products/presentation/widgets/search_results_view.dart';
import '../../../wedding_products/presentation/widgets/products_section.dart';
import '../bloc/products_bloc.dart';


class WeddingProductsViewBody extends StatefulWidget {
  const WeddingProductsViewBody({super.key});

  @override
  State<WeddingProductsViewBody> createState() => _WeddingProductsViewBodyState();
}

class _WeddingProductsViewBodyState extends State<WeddingProductsViewBody> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        BlocProvider.of<ProductsBloc>(context).add(SearchProducts(query));
      } else {
        setState(() {
          searchResults = [];
        });
        BlocProvider.of<ProductsBloc>(context).add(LoadWeddingProducts("cakes", type: "Wedding"));
        // يمكنك إضافة باقي الفئات هنا
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductsLoaded && state.categoryId == "search_results") {
          setState(() {
            searchResults = state.products;
          });
        }
      },
      child: Container(
        color: const Color(0xFFEEC9C4),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Center(
                  child: Text(
                    "Occasio",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SearchBarWidget(controller: _searchController),
                const SizedBox(height: 18),
                if (searchResults.isNotEmpty)
                  SearchResultsView(products: searchResults)
                else
                  Column(
                    children: const [
                      ProductsSection(title: "Cakes", categoryId: "cakes"),
                      SizedBox(height: 18),
                      ProductsSection(title: "Decoration", categoryId: "Decoration"),
                      SizedBox(height: 18),
                      ProductsSection(title: "Candies", categoryId: "Candies"),
                      SizedBox(height: 18),
                      ProductsSection(title: "Refreshment", categoryId: "Refreshment"),
                      SizedBox(height: 18),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
