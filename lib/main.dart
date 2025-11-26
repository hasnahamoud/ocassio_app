// lib/main.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/birthday_products/presentation/views/birthday_products_view.dart';
import 'package:ocassio_app/features/graduation_products/presentation/views/graduation_products_view.dart';
import 'package:ocassio_app/features/login/presentation/views/log_in_view.dart';
import 'package:ocassio_app/features/product_details/presentation/views/product_view.dart';
import 'package:ocassio_app/features/profile/presentation/views/profile_view.dart';
import 'package:ocassio_app/features/reveal_products/presentation/views/reveal_products_view.dart';
import 'package:ocassio_app/features/sign_up/presentation/views/sign_up_view.dart';
import 'package:ocassio_app/features/splash/presentation/splash_view.dart';

import 'features/categories/data/models/category_model.dart';
import 'features/categories/presentation/views/categories_view.dart';
import 'features/checkout/data/repositories/checkout_repository_imp.dart';
import 'features/hajj_products/presentation/views/hajj_products_view.dart';
import 'features/product_details/domain/entities/product_detail.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/views/cart_view.dart';

import 'features/checkout/data/data_sources/checkout_remote_data_source.dart';
import 'features/checkout/presentation/bloc/checkout_bloc.dart';
import 'features/checkout/presentation/views/checkout_view.dart';
import 'package:http/http.dart' as http;
import 'features/cart/domain/entities/cart_item.dart';
import 'features/wedding_products/presentation/views/wedding_products_view.dart';

void main() {
  runApp(const ocassioApp());
}

class ocassioApp extends StatelessWidget {
  const ocassioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(cartRepository: CartRepositoryImpl()),
        ),
        BlocProvider<CheckoutBloc>(
          create: (context) => CheckoutBloc(
            checkoutRepository: CheckoutRepositoryImpl(
              remoteDataSource: CheckoutRemoteDataSource(client: http.Client()),
            ),
            cartRepository: RepositoryProvider.of<CartBloc>(context).cartRepository,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashView.id,
        routes: {
          ProductDetailsView.id: (context) {
            final product = ModalRoute.of(context)?.settings.arguments as ProductDetail?;
            if (product == null) {
              debugPrint('Error: Product details are null when navigating to ProductDetailsView.');
              return const Scaffold(body: Center(child: Text('Product details not found!')));
            }
            return ProductDetailsView(product: product);
          },
          WeddingProductsView.id:(context)=>WeddingProductsView(),
          HajjProductsView.id:(context)=>HajjProductsView(),

          GraduationProductsView.id:(context)=>GraduationProductsView(),
          RevealProductsView.id:(context)=>RevealProductsView(),
          BirthdayProductsView.id: (context) => const BirthdayProductsView(),
          signView.id: (context) => const signView(),
          loginView.id: (context) => const loginView(),
          ProfileView.id: (context) => const ProfileView(),

          CategoriesView.id: (context) => CategoriesView(
            categories: [
              CategoryModel(id: 'c0', title: 'Graduation', image: 'assets/images/hasna1.jpg'),
              CategoryModel(id: 'c1', title: 'Reveal', image: 'assets/images/hasna.jpg'),
              CategoryModel(id: 'c2', title: 'Birthday', image: 'assets/images/hasna2.jpg'),
              CategoryModel(id: 'c3', title: 'Wedding', image: 'assets/images/hasna3.jpg'),
              CategoryModel(id: 'c4', title: 'Al-Hajj', image: 'assets/images/photo_٢٠٢٥-٠٨-٣١_١٦-٠٤-٥٢.jpg'),

            ],
          ),
          CartView.id: (context) => const CartView(),

          CheckoutView.id: (context) {
            final args = ModalRoute.of(context)?.settings.arguments;

            if (args is Map<String, dynamic> &&
                args.containsKey('cartItems') &&
                args.containsKey('totalPrice')) {

              final List<dynamic>? rawCartItemsJson = args['cartItems'];
              final double? totalPrice = args['totalPrice'] as double?;

              if (rawCartItemsJson == null || totalPrice == null) {
                return const Scaffold(body: Center(child: Text('Checkout data is corrupted!')));
              }

              final List<CartItem> cartItems = rawCartItemsJson.map((itemJson) {
                if (itemJson is Map<String, dynamic>) {
                  return CartItem.fromJson(itemJson);
                }
                throw Exception('Invalid JSON format for cart item received.');
              }).toList();

              return CheckoutView(cartItems: cartItems, totalPrice: totalPrice);
            } else {
              debugPrint('Error: Arguments for CheckoutView are missing or have an invalid format.');
              return const CartView();
            }
          },
          SplashView.id: (context) => const SplashView(),
        },
      ),
    );
  }
}
