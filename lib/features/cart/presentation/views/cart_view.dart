// lib/features/cart/presentation/views/cart_view.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/core/utils/constsnts.dart';
import '../../../checkout/presentation/views/checkout_view.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_item_widget.dart';

class CartView extends StatefulWidget {
  static const String id = 'CartView';
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(GetCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcolor,
      appBar: AppBar(
        title: Column(
          children: [
            const SizedBox(height: 40),
            const Text('My Cart', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),

          ],
        ),
        backgroundColor: kcolor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return const Center(
                child: Text('Your cart is empty!', style: TextStyle(fontSize: 18, color: Colors.grey)),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return CartItemWidget(item: item);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Price:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                          Text(
                            '\$${state.totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),

                      ElevatedButton(
                        onPressed: () {
                          if (state is CartLoaded && state.items.isNotEmpty) {
                            final List<Map<String, dynamic>> itemsJson =
                            state.items.map((item) => item.toJson()).toList();

                            Navigator.pushNamed(
                              context,
                              CheckoutView.id,
                              // 💡 التعديل هنا: تأكد من أن الكائن هو Map<String, dynamic>
                              arguments: {
                                'cartItems': itemsJson,
                                'totalPrice': state.totalPrice,
                              } as Map<String, dynamic>, // 💡 هذا هو الحل: تأكيد نوع الكائن
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Your cart is empty!')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kkkColor,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
          }
          return const SizedBox();
        },
      ),
    );
  }
}