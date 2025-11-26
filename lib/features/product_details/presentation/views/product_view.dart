import 'package:flutter/material.dart';
import 'package:ocassio_app/features/product_details/presentation/widgets/product_view_body.dart';
import '../../../../core/utils/constsnts.dart';
import '../../domain/entities/product_detail.dart';

class ProductDetailsView extends StatelessWidget {
  static const String id = 'productDetailsView';

  final ProductDetail product;
  const ProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:kcolor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () {
            Navigator.pop(context); //
          },
        ),
      ),
      body: ProductDetailsViewBody(product: product),
    );
  }
}
