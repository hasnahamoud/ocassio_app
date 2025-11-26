// lib/features/profile/presentation/bloc/profile_state.dart
import '../../domain/entities/user_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;
  ProfileLoaded(this.user);
}

class ProfileUpdatePasswordSuccess extends ProfileState {}

class ProfileLoggedOut extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}