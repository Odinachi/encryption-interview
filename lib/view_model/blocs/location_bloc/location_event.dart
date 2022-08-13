part of "location_bloc.dart";

abstract class LocationEvent {
  const LocationEvent();
}

class CompleteSignUp extends LocationEvent {
  final String country;
  final String password;
  final String fullName;
  final String email;

  CompleteSignUp(
      {required this.email,
      required this.password,
      required this.fullName,
      required this.country});
}
