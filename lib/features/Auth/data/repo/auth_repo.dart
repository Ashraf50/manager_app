abstract class AuthRepo {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });
  Future<Map<String, dynamic>> forgetPassword({
    required String email,
  });
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirm,
  });
  Future<Map<String, dynamic>> verifyCode({
    required String email,
    required String code,
  });
  Future<bool> isLoggedIn();
  Future<void> logout();
}
