import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/core/utils/constsnts.dart';
import '../../domain/entities/cart_item.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.product.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:15,),
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (item.quantity > 1) {
                          BlocProvider.of<CartBloc>(context).add(UpdateItemQuantity(item.product.id, item.quantity - 1));
                        } else {
                          BlocProvider.of<CartBloc>(context).add(RemoveItemFromCart(item.product.id));
                        }
                      },
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.brown),
                      iconSize: 32,
                    ),
                    Text(
                      item.quantity.toString(),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context).add(UpdateItemQuantity(item.product.id, item.quantity + 1));
                      },
                      icon: const Icon(Icons.add_circle_outline, color: Colors.brown),
                      iconSize: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<CartBloc>(context).add(RemoveItemFromCart(item.product.id));
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
