// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import './widgets/user_transactions.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Column(
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
          UserTransactions(),
        ],
      ),
    );
  }
}
