part of "pin_bloc.dart";

abstract class PinEvent {
  const PinEvent();
}

class SaveEvent extends PinEvent {
  final String pincode;
  final String token;

  SaveEvent({required this.pincode, required this.token});
}

class LoginEvent extends PinEvent {
  final String pincode;

  LoginEvent({
    required this.pincode,
  });
}
