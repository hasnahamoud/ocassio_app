import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/sign_up_repository.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository signUpRepository;

  SignUpBloc({required this.signUpRepository}) : super(SignUpInitial()) {
    on<SignUpButtonPressed>((event, emit) async {
      emit(SignUpLoading());
      try {
        await signUpRepository.signUp(
          name: event.name,
          email: event.email,
          password: event.password,
        );
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
  }
}
