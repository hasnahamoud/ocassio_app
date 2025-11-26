abstract class SignUpRepository {
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
}
