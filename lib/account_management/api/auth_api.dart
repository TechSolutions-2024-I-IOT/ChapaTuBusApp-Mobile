import 'package:chapa_tu_bus_app/account_management/application/auth_facade_service.dart';
import 'package:chapa_tu_bus_app/account_management/domain/entities/user.dart';
import 'package:chapa_tu_bus_app/injections.dart';

class AuthApi {
  final AuthFacadeService _authFacadeService = serviceLocator<AuthFacadeService>();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _authFacadeService.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    await _authFacadeService.signInWithGoogle();
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    await _authFacadeService.signUpWithEmailAndPassword(
        email: email, password: password, name: name);
  }

  Future<void> signOut() async {
    await _authFacadeService.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await _authFacadeService.resetPassword(email: email);
  }

  Future<User?> getCurrentUser() async {
    return await _authFacadeService.getCurrentUser();
  }

  Future<void> updateUser({required User user}) async {
    await _authFacadeService.updateUser(user: user);
  }


}