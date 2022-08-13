part of "sign_up_bloc.dart";

abstract class SignUpEvent {
  const SignUpEvent();
}

class RegisterEvent extends SignUpEvent {
  final String fullname;
  final String email;
  final String password;
  final String country;
  RegisterEvent(
      {required this.email,
      required this.password,
      required this.fullname,
      required this.country});
}
