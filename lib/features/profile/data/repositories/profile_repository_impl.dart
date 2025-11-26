// lib/features/profile/data/repositories/profile_repository_impl.dart
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> getUserProfile() {
    return remoteDataSource.getUserProfile();
  }

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return remoteDataSource.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }
}