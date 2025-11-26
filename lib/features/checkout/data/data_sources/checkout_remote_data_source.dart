// lib/features/checkout/data/data_sources/checkout_remote_data_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../models/checkout_model.dart';

class CheckoutRemoteDataSource {
  final http.Client client;

  CheckoutRemoteDataSource({required this.client});

  Future<OrderModel> createOrder({
    required List<CartItem> items,
    required double totalAmount,
    required String paymentMethod,
  }) async {
    final url = Uri.parse('http://10.31.22.213:9000/api/v1.0.0/orders');

    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('authToken');

    if (storedToken == null || storedToken.isEmpty) {
      throw Exception('Authentication token not found. Please log in.');
    }

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $storedToken',
      },
      body: jsonEncode({
        'cart': items.map((item) => item.toJson()).toList(),
        'address': 'Dummy Address',
        'methodPayment': 'cash',
        'total': totalAmount,
      }),
    );

    // 💡 التعديل هنا: طباعة الاستجابة للتحقق منها
    if (response.statusCode == 201) {
      print('Successful order creation. Response body: ${response.body}');
      try {
        final responseBody = jsonDecode(response.body);
        if (responseBody is Map<String, dynamic> && responseBody.containsKey('doc')) {
          return OrderModel.fromJson(responseBody['doc'] as Map<String, dynamic>);
        } else {
          // 💡 في حالة أن الاستجابة ناجحة لكن التنسيق غير صحيح
          throw Exception('Invalid response format from server.');
        }
      } catch (e) {
        // 💡 في حالة أن التحليل فشل
        throw Exception('Failed to parse order response: $e');
      }
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception('Failed to create order: ${response.statusCode} - ${errorBody['message'] ?? 'Unknown error'}');
    }
  }
}