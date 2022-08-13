part of "dashboard_bloc.dart";

abstract class DashboardState {
  const DashboardState();
}

class DashboardInit extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardFailed extends DashboardState {
  final String error;
  DashboardFailed({required this.error});
}

class DashboardSuccess extends DashboardState {
  final String message;
  DashboardSuccess({required this.message});
}
