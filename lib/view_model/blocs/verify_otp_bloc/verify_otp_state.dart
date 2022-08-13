part of "verify_otp_bloc.dart";

abstract class VerifyOtpState {
  const VerifyOtpState();
}

class VerifyOtpInit extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpFailed extends VerifyOtpState {
  final String error;
  VerifyOtpFailed({required this.error});
}

class VerifyOtpSuccess extends VerifyOtpState {
  final String email;
  VerifyOtpSuccess({required this.email});
}
