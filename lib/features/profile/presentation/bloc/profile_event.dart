// lib/features/profile/presentation/bloc/profile_event.dart
import '../../domain/entities/user_entity.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdatePassword extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  UpdatePassword({required this.currentPassword, required this.newPassword});
}

class Logout extends ProfileEvent {}