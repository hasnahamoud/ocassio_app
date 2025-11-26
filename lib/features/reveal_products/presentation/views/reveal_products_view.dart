

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/reveal_products/data/repositories/product_repository_impl.dart';
import 'package:ocassio_app/features/reveal_products/presentation/bloc/products_bloc.dart';
import 'package:ocassio_app/features/reveal_products/presentation/bloc/products_event.dart';
import 'package:http/http.dart' as http;

import '../../../login/presentation/widgets/customBottomAppBar.dart';
import '../../data/data_sources/reveal_remote_data_source.dart';
import '../widgets/reveal_products_view_body.dart';

class RevealProductsView extends StatefulWidget {
  const RevealProductsView({super.key});
  static String id = 'RevealProductsView';

  @override
  State<RevealProductsView> createState() => _RevealProductsViewState();
}

class _RevealProductsViewState extends State<RevealProductsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        repository: ProductRepositoryImpl(
          remoteDataSource: RevealRemoteDataSource(client: http.Client()),
        ),
      )
      // إضافة الأحداث لجميع الفئات، مع تحديد 'type' كـ "Birthday"
        ..add(LoadRevealProducts("cakes", type: "Reveal"))
        ..add(LoadRevealProducts("Decoration", type: "Reveal"))
        ..add(LoadRevealProducts("Candies", type: "Reveal"))
        ..add(LoadRevealProducts("Refreshment", type: "Reveal")),
      child: const Scaffold(
          body: RevealProductsViewBody(),
          bottomNavigationBar: Custombottomappbar()

      ),
    );
  }
}
