import 'package:ocassio_app/features/login/domain/repositories/login_repository.dart';
import 'package:ocassio_app/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <--- إضافة استيراد SharedPreferences

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> login({required String email, required String password}) async {
    // استلام الرد كاملاً من الـ remoteDataSource
    final responseBody = await remoteDataSource.login(email: email, password: password);

    // افتراض أن التوكن يأتي في حقل 'token' من الـ API
    final String? token = responseBody['token'];

    if (token != null && token.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token); // <--- حفظ التوكن في SharedPreferences
      print('Authentication token saved successfully: $token');
    } else {
      // التعامل مع حالة عدم وجود توكن في الرد (قد يكون خطأ في الـ Backend)
      throw Exception('Login successful but no token received.');
    }
  }
}
