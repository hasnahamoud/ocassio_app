// lib/features/profile/data/data_sources/profile_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class ProfileRemoteDataSource {
  final http.Client client;
  ProfileRemoteDataSource({required this.client});

  final String baseUrl = 'http://10.31.22.213:9000/api/v1.0.0/users';

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token not found. Please log in.');
    }
    return token;
  }

  Future<UserModel> getUserProfile() async {
    final token = await _getToken();
    final uri = Uri.parse('$baseUrl/me');
    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final token = await _getToken();
    final uri = Uri.parse('$baseUrl/updateMyPassword');
    final response = await client.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'passwordCurrent': currentPassword,
        'password': newPassword,
        'passwordConfirm': newPassword, // تأكد أن الـ API يتوقع هذا
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update password: ${json.decode(response.body)['message']}');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    // يمكنك إضافة منطق آخر لتسجيل الخروج هنا إذا كان الـ API يتطلب ذلك
  }
}