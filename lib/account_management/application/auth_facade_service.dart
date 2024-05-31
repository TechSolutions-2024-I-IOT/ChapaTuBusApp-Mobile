import 'package:chapa_tu_bus_app/account_management/domain/entities/user.dart';
import 'package:chapa_tu_bus_app/account_management/domain/interfaces/i_auth_repository.dart';
import 'package:chapa_tu_bus_app/account_management/domain/logic/get_current_user.dart';
import 'package:chapa_tu_bus_app/account_management/domain/logic/reset_password.dart';
import 'package:chapa_tu_bus_app/account_management/domain/logic/sign_in_with_email_and_password.dart';
import 'package:chapa_tu_bus_app/account_management/domain/logic/sign_in_with_google.dart';
import 'package:chapa_tu_bus_app/account_management/domain/logic/sign_out.dart';
import 'package:chapa_tu_bus_app/account_management/domain/logic/sign_up_with_email_and_password.dart';
import 'package:chapa_tu_bus_app/account_management/domain/logic/update_user.dart';


class AuthFacadeService {
  final SignInWithEmailAndPassword _signInWithEmailAndPassword;
  final SignInWithGoogle _signInWithGoogle;
  final SignUpWithEmailAndPassword _signUpWithEmailAndPassword;
  final SignOut _signOut;
  final ResetPassword _resetPassword;
  final GetCurrentUser _getCurrentUser;
  final UpdateUser _updateUser;

  AuthFacadeService({
    required IAuthRepository authRepository,
    required SignInWithEmailAndPassword signInWithEmailAndPassword,
    required SignInWithGoogle signInWithGoogle,
    required SignUpWithEmailAndPassword signUpWithEmailAndPassword,
    required SignOut signOut,
    required ResetPassword resetPassword,
    required GetCurrentUser getCurrentUser,
    required UpdateUser updateUser,
  })  : _signInWithEmailAndPassword = signInWithEmailAndPassword,
        _signInWithGoogle = signInWithGoogle,
        _signUpWithEmailAndPassword = signUpWithEmailAndPassword,
        _signOut = signOut,
        _resetPassword = resetPassword,
        _getCurrentUser = getCurrentUser,
        _updateUser = updateUser;

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    await _signInWithGoogle();
  }

  Future<void> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    await _signUpWithEmailAndPassword(
        email: email, password: password, name: name);
  }

  Future<void> signOut() async {
    await _signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await _resetPassword(email: email);
  }

  Future<User?> getCurrentUser() async {
    return await _getCurrentUser();
  }

  Future<void> updateUser({required User user}) async {
    return await _updateUser(user: user);
  }
}