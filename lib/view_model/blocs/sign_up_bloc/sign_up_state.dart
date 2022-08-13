part of "sign_up_bloc.dart";

abstract class SignUpState {
  const SignUpState();
}

class SignUpInit extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpFailed extends SignUpState {
  final String error;
  SignUpFailed({required this.error});
}

class SignUpSuccess extends SignUpState {
  final String email;
  SignUpSuccess({required this.email});
}
