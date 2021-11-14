// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transactions.dart';

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

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, //adjust it's look vertically on screen.
        crossAxisAlignment:
            CrossAxisAlignment.center, //adjust its look hoizontally.
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
          Column(
            children: [
              // spread operator solves a bug about a list of widgets not working with map
              // to put a dynamic amount of objects in a column use map and return whatever widget you want but add .toList() at the end.
              ...transactions.map((tx) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2)),
                        child: Text(
                          //This is how you can use string interpulation and how to show dollar signs since they are a reserved character in dart, so \$ to show them.
                          '\$ ${tx.amount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('MMM dd, yyyy').format(tx.date),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ],
          )
        ],
      ),
    );
  }
}
