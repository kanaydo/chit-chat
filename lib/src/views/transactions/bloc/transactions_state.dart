part of 'transactions_cubit.dart';

@immutable
abstract class TransactionsState {}

class TransactionsIdle extends TransactionsState {
  final List<Transaction> transactions;
  TransactionsIdle({this.transactions});
}

class TransactionsLoading extends TransactionsState {
  final String message;
  TransactionsLoading({this.message});
}

class TransactionsError extends TransactionsState {
  final String message;
  TransactionsError({this.message});
}

class TransactionsFatalError extends TransactionsState {
  final String message;
  TransactionsFatalError({this.message});
}