/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/birthday_products/presentation/bloc/products_bloc.dart';
import 'package:ocassio_app/features/birthday_products/presentation/bloc/products_event.dart';
import 'search_bar.dart';
import 'products_section.dart';

class BirthdayProductsViewBody extends StatefulWidget {
  const BirthdayProductsViewBody({super.key});

  @override
  State<BirthdayProductsViewBody> createState() => _BirthdayProductsViewBodyState();
}

class _BirthdayProductsViewBodyState extends State<BirthdayProductsViewBody> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // 💡 إضافة listener لحقل البحث
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        BlocProvider.of<ProductsBloc>(context).add(SearchProducts(_searchController.text));
      } else {
        // إعادة تحميل الفئات الأصلية عند إفراغ حقل البحث
        BlocProvider.of<ProductsBloc>(context).add(LoadBirthdayProducts("cakes", type: "Birthday"));
        // يمكنك إضافة باقي الفئات هنا
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEC9C4), // الخلفية الوردية
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              SizedBox(height: 32),
              Center(
                child: Text(
                  "Occasio",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
              SizedBox(height: 18),
              SearchBarWidget(controller:_searchController,),
              SizedBox(height: 18),
              ProductsSection(title: "Cakes", categoryId: "cakes"),
              SizedBox(height: 18),
              ProductsSection(title: "Decoration", categoryId: "Decoration"), // <--- تأكدنا من المطابقة
              SizedBox(height: 18),
              ProductsSection(title: "Candies", categoryId: "Candies"),     // <--- تم التعديل هنا
              SizedBox(height: 18),
              ProductsSection(title: "Refreshment", categoryId: "Refreshment"), // <--- القسم الجديد
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}*/// lib/features/birthday_products/presentation/widgets/hajj_products_view_body.dart


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/graduation_products/domain/product.dart';
import 'package:ocassio_app/features/graduation_products/presentation/bloc/products_bloc.dart';
import 'package:ocassio_app/features/graduation_products/presentation/bloc/products_event.dart';
import 'package:ocassio_app/features/graduation_products/presentation/bloc/products_state.dart';
import 'package:ocassio_app/features/graduation_products/presentation/widgets/products_section.dart';
import 'package:ocassio_app/features/graduation_products/presentation/widgets/search_bar.dart';
import 'package:ocassio_app/features/graduation_products/presentation/widgets/search_results_view.dart';

class GraduationProductsViewBody extends StatefulWidget {
  const GraduationProductsViewBody({super.key});

  @override
  State<GraduationProductsViewBody> createState() => _GraduationProductsViewBodyState();
}

class _GraduationProductsViewBodyState extends State<GraduationProductsViewBody> {
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
        BlocProvider.of<ProductsBloc>(context).add(LoadGraduationProducts("cakes", type: "Graduation"));
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
