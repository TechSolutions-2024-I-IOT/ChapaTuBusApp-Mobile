import 'package:chapa_tu_bus_app/account_management/domain/entities/user.dart';

abstract class IAuthRepository {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithGoogle();

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<void> signOut();

  Future<void> resetPassword({required String email});

  Future<User?> getCurrentUser();

  Future<void> updateUser({required User user});

}