import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/model/transaction.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/responses/transactions_response.dart';
import 'package:flutter_base_app/src/utils/messages.dart';
import 'package:flutter_base_app/src/utils/session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'transactions_state.dart';


class TransactionsCubit extends Cubit<TransactionsState> {

  SessionManager sessionManager = SessionManager();
  MemberRepository memberRepository = MemberRepository();
  List<Transaction> transactions = [];

  TransactionsCubit() : super(null){
    getMemberTransactions();
  }

  void getMemberTransactions() async {
    emit(TransactionsLoading(message: Messages.TRANSACTIONS_LOADING));
    int memberId = await sessionManager.getActiveMember();
    if (memberId != 0) {
      try {
        TransactionsResponse transactionsResponse = await memberRepository.getMemberTransactions(memberId);
        this.transactions = transactionsResponse.transactions;
        emit(TransactionsIdle(transactions: transactions));
      } on ApiException catch (apiE) {
        emit(TransactionsError(message: apiE.toString()));
        emit(TransactionsIdle(transactions: transactions));
      } catch (e) {
        emit(TransactionsFatalError(message: e.toString()));
      }
    }
  }

}