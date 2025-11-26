// lib/features/profile/domain/repositories/profile_repository.dart
import '../entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getUserProfile();
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<void> logout();
}