part of "pin_bloc.dart";

abstract class PinState {
  const PinState();
}

class PinInit extends PinState {}

class PinLoading extends PinState {}

class PinFailed extends PinState {
  final String error;
  PinFailed({required this.error});
}

class PinSuccess extends PinState {}
