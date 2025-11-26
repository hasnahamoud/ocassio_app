import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../login/presentation/widgets/customBottomAppBar.dart';
import '../../data/data_sources/birthday_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import 'package:http/http.dart' as http;
import '../widgets/birthday_products_view_body.dart';

class BirthdayProductsView extends StatefulWidget {
  const BirthdayProductsView({super.key});
  static String id = 'BirthdayProductsView';

  @override
  State<BirthdayProductsView> createState() => _BirthdayProductsViewState();
}

class _BirthdayProductsViewState extends State<BirthdayProductsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        repository: ProductRepositoryImpl(
          remoteDataSource: BirthdayRemoteDataSource(client: http.Client()),
        ),
      )
      // إضافة الأحداث لجميع الفئات، مع تحديد 'type' كـ "Birthday"
        ..add(LoadBirthdayProducts("cakes", type: "Birthday"))
        ..add(LoadBirthdayProducts("Decoration", type: "Birthday"))
        ..add(LoadBirthdayProducts("Candies", type: "Birthday"))
        ..add(LoadBirthdayProducts("Refreshment", type: "Birthday")),
      child: const Scaffold(
        body: BirthdayProductsViewBody(),
          bottomNavigationBar: Custombottomappbar()

      ),
    );
  }
}
