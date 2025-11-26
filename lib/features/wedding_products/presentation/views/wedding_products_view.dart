

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/wedding_products/data/repositories/product_repository_impl.dart';
import 'package:ocassio_app/features/wedding_products/presentation/bloc/products_bloc.dart';
import 'package:ocassio_app/features/wedding_products/presentation/bloc/products_event.dart';
import 'package:http/http.dart' as http;

import '../../../login/presentation/widgets/customBottomAppBar.dart';
import '../../data/data_sources/wedding_remote_data_source.dart';
import '../widgets/wedding_products_view_body.dart';

class WeddingProductsView extends StatefulWidget {
  const WeddingProductsView({super.key});
  static String id = 'WeddingProductsView';

  @override
  State<WeddingProductsView> createState() => _WeddingProductsViewState();
}

class _WeddingProductsViewState extends State<WeddingProductsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        repository: ProductRepositoryImpl(
          remoteDataSource: WeddingRemoteDataSource(client: http.Client()),
        ),
      )
      // إضافة الأحداث لجميع الفئات، مع تحديد 'type' كـ "Birthday"
        ..add(LoadWeddingProducts("cakes", type: "Wedding"))
        ..add(LoadWeddingProducts("Decoration", type: "Wedding"))
        ..add(LoadWeddingProducts("Candies", type: "Wedding"))
        ..add(LoadWeddingProducts("Refreshment", type: "Wedding")),
      child: const Scaffold(
          body: WeddingProductsViewBody(),
          bottomNavigationBar: Custombottomappbar()

      ),
    );
  }
}
