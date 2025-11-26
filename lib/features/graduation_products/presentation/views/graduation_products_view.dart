import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/graduation_products/data/data_sources/graduation_remote_data_source.dart';
import 'package:ocassio_app/features/graduation_products/data/repositories/product_repository_impl.dart';
import 'package:ocassio_app/features/graduation_products/presentation/widgets/graduation_products_view_body.dart';
import '../../../login/presentation/widgets/customBottomAppBar.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import 'package:http/http.dart' as http;

class  GraduationProductsView extends StatefulWidget {
  const GraduationProductsView({super.key});
  static String id = 'GraduationProductsView';

  @override
  State<GraduationProductsView> createState() => _GraduationProductsViewState();
}

class _GraduationProductsViewState extends State<GraduationProductsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        repository: ProductRepositoryImpl(
          remoteDataSource: GraduationRemoteDataSource(client: http.Client()),
        ),
      )
        ..add(LoadGraduationProducts("cakes", type: "Graduation"))
        ..add(LoadGraduationProducts("Decoration", type: "Graduation"))
        ..add(LoadGraduationProducts("Candies", type: "Graduation"))
        ..add(LoadGraduationProducts("Refreshment", type: "Graduation")),
      child: const Scaffold(
          body: GraduationProductsViewBody(),
          bottomNavigationBar: Custombottomappbar()

      ),
    );
  }
}
