import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/core/utils/constsnts.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../categories/presentation/views/categories_view.dart';
import '../bloc/checkout_bloc.dart';
import '../bloc/checkout_event.dart';
import '../bloc/checkout_state.dart';

class CheckoutView extends StatelessWidget {
  static const String id = 'CheckoutView';
  final List<CartItem> cartItems;
  final double totalPrice;

  const CheckoutView({super.key, required this.cartItems, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcolor,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kcolor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Order Placed Successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              CategoriesView.id, // <--- يجب أن يكون هذا الـ ID الخاص بواجهة الفئات
                  (route) => false,
            );
         //   Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state is CheckoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Summary:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        color: Colors.pink[50],
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item.product.image,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 60,
                                      width: 60,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.broken_image, size: 30, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Quantity: ${item.quantity}',
                                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '\$${(item.product.price * item.quantity).toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Payment Method:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  color: Colors.pink[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.money, color: Colors.green),
                    title: const Text('Cash on Delivery', style: TextStyle(color: Colors.brown)),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                    onTap: () {
                      // في هذا التصميم، الدفع نقداً هو الخيار الوحيد، لكن يمكن تطويره لاحقاً
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color:Colors.brown,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CheckoutBloc>(context).add(
                        PlaceOrder(
                          items: cartItems,
                          totalAmount: totalPrice,
                          paymentMethod: 'cash', // <--- تم التعديل هنا
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kkkColor,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Place Order',
                      style: TextStyle(fontSize: 20, color: Colors.brown, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
