import 'package:bloc/bloc.dart';
import 'package:chapa_tu_bus_app/account_management/application/auth_facade_service.dart';
import 'package:chapa_tu_bus_app/account_management/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthFacadeService _authFacadeService;

  AuthBloc({required AuthFacadeService authFacadeService})
      : _authFacadeService = authFacadeService,
        super(AuthInitialState()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignInWithEmailAndPasswordRequested>(_onSignInWithEmailAndPasswordRequested);
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<SignUpWithEmailAndPasswordRequested>(_onSignUpWithEmailAndPasswordRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authFacadeService.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInWithEmailAndPasswordRequested(
      SignInWithEmailAndPasswordRequested event,
      Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authFacadeService.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthSuccess());
      final user = await _authFacadeService.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user: user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInWithGoogleRequested(
      SignInWithGoogleRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authFacadeService.signInWithGoogle();
      emit(AuthSuccess());
      final user = await _authFacadeService.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user: user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpWithEmailAndPasswordRequested(
      SignUpWithEmailAndPasswordRequested event,
      Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authFacadeService.signUpWithEmailAndPassword(
          email: event.email, password: event.password, name: event.name);
      emit(AuthSuccess());
      final user = await _authFacadeService.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user: user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authFacadeService.signOut();
      emit(UnAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onResetPasswordRequested(
      ResetPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authFacadeService.resetPassword(email: event.email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

