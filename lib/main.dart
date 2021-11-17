// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    //understand using the word final means the pointer to this list is final, not the list iteself! so I can add and mutate this list even though it says final at first.
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now())
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

//show the add transaction modal widget when clicked.
//ctx is the context (meta info that flutter uses) we pass to this function to pass to the modalBottomSheet
//the builder requires its own context but currently we do nothing with that context so its just _ ,
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
        title: const Text('Flutter App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, //adjust it's look vertically on screen.
          crossAxisAlignment:
              CrossAxisAlignment.stretch, //adjust its look hoizontally.
          children: [
            //Note: Card will assume the size of its child unless you specify for it to be bigger with a container (either wrap the card with a container with set width or do it to its child).
            Card(
              child: Container(
                child: Text('CHART!'),
                width: double.infinity,
              ),
              color: Colors.blue,
              elevation:
                  5, //how 'high' or 'forward' this card looks. so the drop shadow is stronger too.
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      //Notice how floating action buttons are NOT in the body of this app.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
