part of 'redeem_cubit.dart';

@immutable
abstract class RedeemState {}

class RedeemIdle extends RedeemState {

}

class RedeemLoading extends RedeemState {
  final String message;
  RedeemLoading({this.message});
}

class RedeemSuccess extends RedeemState {
  final Redeem redeem;
  RedeemSuccess({this.redeem});
}

class RedeemError extends RedeemState {
  final String message;
  RedeemError({this.message});
}

class RedeemFatalError extends RedeemState {
  final String message;
  RedeemFatalError({this.message});
}

class RedeemProfileNotCompleted extends RedeemState {}