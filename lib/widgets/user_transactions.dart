import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transactions.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

final List<Transaction> _userTransactions = [
  //understand using the word final means the pointer to this list is final, not the list iteself! so I can add and mutate this list even though it says final at first.
  Transaction(
      id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
  Transaction(
      id: 't2', title: 'Weekly Groceries', amount: 16.53, date: DateTime.now())
];

class _UserTransactionsState extends State<UserTransactions> {
  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          NewTransaction(_addNewTransaction),
          TransactionList(_userTransactions)
        ],
      ),
    );
  }
}
