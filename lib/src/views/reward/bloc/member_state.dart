part of 'member_cubit.dart';

@immutable
abstract class MemberState {}

class IdleMember extends MemberState {
  final Member member;
  IdleMember(this.member);
}

class LoadingMember extends MemberState {
  final String message;
  LoadingMember(this.message);
}

class ErrorMember extends MemberState {
  final String message;
  ErrorMember(this.message);
}

