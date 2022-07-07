import 'package:wa_test_app/repository/auth/auth_repository.dart';

class AuthService {
  final AuthRepository _repo = AuthRepository();

  /// Checks if user is allowed. Returns true if e-mail is allowed or false if is
  /// not.
  Future<bool> tryLogin(String email) async {
    var list = await _repo.getEmailList();
    return list.any((element) => element == email);
  }
}