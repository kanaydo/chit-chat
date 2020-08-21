part of 'welcome_cubit.dart';

@immutable
abstract class WelcomeState {}

class IdleBanner extends WelcomeState {
  final List<ImgBanner> banners;
  IdleBanner(this.banners);
}

class LoadingBanner extends WelcomeState {}


class ErrorBanner extends WelcomeState {
  final String message;
  ErrorBanner(this.message);
}