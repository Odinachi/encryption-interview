part of "login_bloc.dart";

abstract class LoginState {
  const LoginState();
}

class LoginInit extends LoginState {}

class LoginLoading extends LoginState {}

class HasAuth extends LoginState {}

class LoginFailed extends LoginState {
  final String error;
  LoginFailed({required this.error});
}

class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess({required this.token});
}
