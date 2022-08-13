part of "verify_otp_bloc.dart";

abstract class VerifyOtpEvent {
  const VerifyOtpEvent();
}

class VerifyEvent extends VerifyOtpEvent {
  final String token;
  final String email;

  VerifyEvent({required this.email, required this.token});
}

class ResendEvent extends VerifyOtpEvent {
  final String email;

  ResendEvent({
    required this.email,
  });
}
