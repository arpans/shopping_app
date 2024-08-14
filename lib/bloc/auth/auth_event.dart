part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class CheckAuthStatusEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
