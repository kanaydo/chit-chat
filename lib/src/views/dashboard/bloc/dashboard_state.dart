part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class IdleDashboard extends DashboardState {
  final User user;
  IdleDashboard({this.user});
}

class LoadingDashboard extends DashboardState {}

class ErrorDashboard extends DashboardState {
  final String message;
  ErrorDashboard(this.message);
}