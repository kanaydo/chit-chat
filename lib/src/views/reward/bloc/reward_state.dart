part of 'reward_cubit.dart';

@immutable
abstract class RewardState {}

class RewardLoaded extends RewardState {
  final List<Reward> rewards;
  RewardLoaded({this.rewards});
}

class RewardLoading extends RewardState {
  final String message;
  RewardLoading({this.message});
}

class RewardError extends RewardState {
  final String message;
  RewardError({this.message});
}

class RewardFatalError extends RewardState {
  final String message;
  RewardFatalError({this.message});
}