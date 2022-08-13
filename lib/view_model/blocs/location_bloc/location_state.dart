part of "location_bloc.dart";

abstract class LocationState {
  const LocationState();
}

class LocationInit extends LocationState {}

class LocationLoading extends LocationState {}

class LocationFailed extends LocationState {
  final String error;
  LocationFailed({required this.error});
}

class LocationSuccess extends LocationState {
  final String token;
  LocationSuccess({required this.token});
}
