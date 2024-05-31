import 'package:bloc/bloc.dart';
import 'package:chapa_tu_bus_app/account_management/api/auth_api.dart';
import 'package:chapa_tu_bus_app/account_management/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthApi _authApi;

  ProfileBloc({required AuthApi authApi})
      : _authApi = authApi,
        super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onProfileLoadRequested);
    on<ProfileSignOutRequested>(_onProfileSignOutRequested);
  }

  Future<void> _onProfileLoadRequested(
      ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = await _authApi.getCurrentUser();
      if (user != null) {
        emit(ProfileLoaded(user: user));
      } else {
        emit(const ProfileError(message: 'Usuario no encontrado'));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onProfileSignOutRequested(
      ProfileSignOutRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await _authApi.signOut();
      emit(ProfileSignOutSuccess());
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
