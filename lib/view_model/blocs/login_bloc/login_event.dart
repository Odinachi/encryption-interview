part of "login_bloc.dart";

abstract class LoginEvent {
  const LoginEvent();
}

class Login extends LoginEvent {
  final String password;

  final String email;

  Login({
    required this.email,
    required this.password,
  });
}

class CheckAuth extends LoginEvent {}
