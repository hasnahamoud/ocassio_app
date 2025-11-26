import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/core/utils/constsnts.dart';
import '../../domain/entities/product_detail.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/views/cart_view.dart'; // <--- استيراد واجهة السلة

class ProductDetailsViewBody extends StatefulWidget {
  final ProductDetail product;
  const ProductDetailsViewBody({super.key, required this.product});

  @override
  _ProductDetailsViewBodyState createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _addToCart() {
    final cartItem = CartItem(product: widget.product, quantity: _quantity);
    BlocProvider.of<CartBloc>(context).add(AddItemToCart(cartItem));

    // إظهار رسالة تأكيد بسيطة
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_quantity}x ${widget.product.name} added to cart!')),
    );

    // الانتقال إلى واجهة السلة بعد إضافة المنتج
    Navigator.pushNamed(context, CartView.id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: kcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),


              ),
              child: Image.network(
                widget.product.image,
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 33,
                        fontFamily: 'Permanent Marker',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'About ${widget.product.name.split(' ').first}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _decrementQuantity,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kkkColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 45,
                          width: 45,
                          child: const Center(
                            child: Icon(Icons.remove, color: Colors.brown),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 45,
                        width: 45,
                        child: Center(
                          child: Text(
                            '$_quantity',
                            style: const TextStyle(fontSize: 28, color: kkkColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _incrementQuantity,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kkkColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 45,
                          width: 45,
                          child: const Icon(Icons.add, color: Colors.brown),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$${(widget.product.price * _quantity).toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: _addToCart,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: kkkColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                'Add To Cart',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
