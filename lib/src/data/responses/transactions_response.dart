import 'package:flutter_base_app/src/data/model/transaction.dart';

class TransactionsResponse {
  List<Transaction> _transactions;

  TransactionsResponse.fromJSON(json) {
    _transactions = List<Transaction>.of(
        json.map<Transaction>((transaction) => new Transaction.fromJSON(transaction))
    );
  }

  List<Transaction> get transactions => _transactions;
}