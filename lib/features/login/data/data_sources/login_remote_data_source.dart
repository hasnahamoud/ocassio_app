import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSource({required this.client});

  Future<Map<String, dynamic>> login({ // يبقى Return type كما هو
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('http://10.31.22.213:9000/api/v1.0.0/users/login');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // طباعة رسالة الخطأ من الـ API إذا كانت موجودة لتكون أوضح
      final errorBody = jsonDecode(response.body);
      throw Exception('Login failed: ${response.statusCode} - ${errorBody['message'] ?? 'Unknown error'}');
    }
  }
}
