// lib/features/profile/presentation/bloc/profile_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await repository.getUserProfile();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdatePassword>((event, emit) async {
      emit(ProfileLoading());
      try {
        await repository.updatePassword(
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
        );
        emit(ProfileUpdatePasswordSuccess());
        // يمكنك إعادة تحميل البروفايل بعد التحديث
        add(LoadProfile());
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<Logout>((event, emit) async {
      try {
        await repository.logout();
        emit(ProfileLoggedOut());
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}