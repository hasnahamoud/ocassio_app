

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ocassio_app/features/graduation_products/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GraduationRemoteDataSource {
  final http.Client client;
  GraduationRemoteDataSource({required this.client});

  Future<List<ProductModel>> fetchProductsByCategory(String categoryId, {String? type}) async {
    print('Fetching products for category: $categoryId with type: ${type ?? "Graduation"}');

    String baseUrl = 'http://10.31.22.213:9000/api/v1.0.0/products?category=$categoryId';
    if (type != null && type.isNotEmpty) {
      baseUrl += '&type=$type';
    }
    final uri = Uri.parse(baseUrl);

    try {
      // جلب التوكن من SharedPreferences ديناميكياً
      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString('authToken');

      if (storedToken == null || storedToken.isEmpty) {
        // إذا لم يكن هناك توكن مخزن، نرفض الطلب ونرمي استثناء
        throw Exception('Authentication token not found or empty. Please log in.');
      }

      final String authToken = 'Bearer $storedToken'; // بناء الـ Header Authorization

      final res = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken, // استخدام التوكن الديناميكي
        },
      );

      print('API Request URL: $uri');
      print('API Response Status Code: ${res.statusCode}');
      print('API Response Body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final list = (body is Map && body['doc'] is List) ? body['doc'] : [];
        print('Parsed List Length: ${list.length}');
        return List<ProductModel>.from(
          list.map((e) => ProductModel.fromMap(e as Map<String, dynamic>)),
        );
      } else {
        throw Exception('Failed to load products: ${res.statusCode} - ${jsonDecode(res.body)['message']}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to load products: $e');
    }
  }
  Future<List<ProductModel>> searchProducts(String query) async {
    print('Searching for: $query');
    final uri = Uri.parse('http://10.31.22.213:9000/api/v1.0.0/products?search=$query');

    try {
      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString('authToken');
      if (storedToken == null || storedToken.isEmpty) {
        throw Exception('Authentication token not found or empty.');
      }
      final res = await client.get(
        uri,
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $storedToken'},
      );

      print('Search API Response Status Code: ${res.statusCode}');
      print('Search API Response Body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final list = (body is Map && body['doc'] is List) ? body['doc'] : [];
        return List<ProductModel>.from(
          list.map((e) => ProductModel.fromMap(e as Map<String, dynamic>)),
        );
      } else {
        throw Exception('Failed to search products: ${res.statusCode} - ${jsonDecode(res.body)['message']}');
      }
    } catch (e) {
      print('Error searching products: $e');
      throw Exception('Failed to search products: $e');
    }
  }
}
