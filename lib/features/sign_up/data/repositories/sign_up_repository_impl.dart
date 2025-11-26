import 'package:ocassio_app/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:ocassio_app/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource remoteDataSource;

  SignUpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await remoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
    );
  }
}
