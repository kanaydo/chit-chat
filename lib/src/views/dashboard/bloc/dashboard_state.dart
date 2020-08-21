part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class IdleDashboard extends DashboardState {
  final Member member;
  final List<ImgBanner> banners;
  IdleDashboard({this.member, this.banners});
}

class LoadingDashboard extends DashboardState {}

class ErrorDashboard extends DashboardState {
  final String message;
  ErrorDashboard(this.message);
}