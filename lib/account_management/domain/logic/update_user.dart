import 'package:chapa_tu_bus_app/account_management/domain/entities/user.dart';
import 'package:chapa_tu_bus_app/account_management/domain/interfaces/i_auth_repository.dart';

class UpdateUser {
  final IAuthRepository _authRepository;

  UpdateUser({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  Future<void> call({required User user}) async {
    return await _authRepository.updateUser(user: user);
  }
}