import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/login/domain/repositories/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LogginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        await loginRepository.login(
          email: event.Email,
          password: event.Password,
        );
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
