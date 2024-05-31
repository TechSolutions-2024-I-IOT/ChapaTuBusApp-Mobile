part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class SignInWithEmailAndPasswordRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInWithEmailAndPasswordRequested(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignInWithGoogleRequested extends AuthEvent {}

class SignUpWithEmailAndPasswordRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const SignUpWithEmailAndPasswordRequested(
      {required this.email,
      required this.password,
      required this.name});

  @override
  List<Object> get props => [email, password, name];
}

class SignOutRequested extends AuthEvent {}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  const ResetPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}