abstract class LoginEvent{}
class LogginButtonPressed extends LoginEvent{
  final String Email;
  final String Password;

  LogginButtonPressed({required this.Email,required this.Password});
}
