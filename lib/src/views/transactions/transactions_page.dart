import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/data/model/transaction.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/views/transactions/bloc/transactions_cubit.dart';
import 'package:flutter_base_app/src/views/transactions/transactions_item.dart';
import 'package:flutter_base_app/src/widget/loa_no_connection.dart';
import 'package:flutter_base_app/src/widget/loa_no_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {

  Future refreshReward(BuildContext context) async {
    context.bloc<TransactionsCubit>().getMemberTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My App',
          style: TextStyle(
            color: BASE_COLOR
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: BASE_COLOR,
            ),
            onPressed: () => Navigator.pop(context)
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocProvider(
          create: (context) => TransactionsCubit(),
          child: BlocListener<TransactionsCubit, TransactionsState>(
            listener: (listenerContext, state) {
              if (state is TransactionsError) {

              }
            },
            child: BlocBuilder<TransactionsCubit, TransactionsState>(
                builder: (builderContext, state) {
                  if (state is TransactionsIdle) {
                    List<Transaction> transactions = state.transactions;
                    if (transactions.length == 0) {
                      return LoaNoData();
                    } else {
                      return RefreshIndicator(
                        onRefresh: () => refreshReward(builderContext),
                        child: ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) => TransactionItem(transaction: transactions[index]),
                        )
                      );
                    }
                  } else if (state is TransactionsFatalError) {
                    return LoaNoConnection(
                        message: state.message,
                        action: () => refreshReward(builderContext)
                    );
                  }else {
                    return Container();
                  }
                }
            ),
          ),
        ),
      ),
    );
  }
}
