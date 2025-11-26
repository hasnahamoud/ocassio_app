import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpRemoteDataSource {
  final http.Client client;

  SignUpRemoteDataSource({required this.client});

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('http://10.31.22.213:9000/api/v1.0.0/users/signup');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Signup failed: ${response.body}');
    }
  }
}
