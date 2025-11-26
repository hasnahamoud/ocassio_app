import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/hajj_products/presentation/bloc/products_event.dart';
import '../../../hajj_products/data/repositories/product_repository_impl.dart';
import '../../../hajj_products/presentation/bloc/products_bloc.dart';
import '../../../login/presentation/widgets/customBottomAppBar.dart';
import 'package:http/http.dart' as http;

import '../../data/data_sources/hajj_remote_data_source.dart';
import '../widgets/hajj_products_view_body.dart';

class HajjProductsView extends StatefulWidget {
  const HajjProductsView({super.key});
  static String id = 'HajjProductsView';

  @override
  State<HajjProductsView> createState() => _HajjProductsViewState();
}

class _HajjProductsViewState extends State<HajjProductsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        repository: ProductRepositoryImpl(
          remoteDataSource: HajjRemoteDataSource(client: http.Client()),
        ),
      )
      // إضافة الأحداث لجميع الفئات، مع تحديد 'type' كـ "Birthday"
        ..add(LoadHajjProducts("cakes", type: "Al-Hajj"))
        ..add(LoadHajjProducts("Decoration", type: "Al-Hajj"))
        ..add(LoadHajjProducts("Candies", type: "Al-Hajj"))
        ..add(LoadHajjProducts("Refreshment", type: "Al-Hajj")),
      child: const Scaffold(
        body: HajjProductsViewBody(),
          bottomNavigationBar: Custombottomappbar()

      ),
    );
  }
}
