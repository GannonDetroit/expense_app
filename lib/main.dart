// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transactions.dart';

void main() {
  // //this line must be called before setting preferred orintations, otherwise you get a bug.
  // WidgetsFlutterBinding.ensureInitialized();
  // //allows you to set system wide settings for the app, such as disabling landscape mode.
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

final ThemeData theme = ThemeData();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      //primaySwatch is best because it auto generates different shade variations of your primary color which many flutter featues will use to make the app look better. just doing primary color will ONLY do that one color.
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
          )
              .copyWith(
                secondary: Colors.amber,
              )
              .copyWith(error: Colors.red),
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),

      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
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
  ];

  List<Transaction> get _recentTransactions {
    //an alternative way to iternative over data instead of using a for-loop, for example sake. where method that dart offers on lists
    //where lets you run a function on all items in a list, if it returns true the item is kept in a newly returned list. So we are using this
    //to compare the date of each transaction and make sure it's from within the last 7 days.
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList(); //where returns an interable, but we want it to be a list to avoid a bug. so add .toList and all good.
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      //allows me to go over a data set and delete anything that meets the specified condition.
      _userTransactions.removeWhere((transaction) {
        return transaction.id == id;
      });
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
    //storing the AppBar widget in this appBar variable because doing it this way allows the appBar varible to be assisible anywhere most importantly
    //gives me information about its height, which I can use for helping make my app more responsive and adapative.
    final appBar = AppBar(
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
      title: const Text(
        'Personal Expenses',
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, //adjust it's look vertically on screen.
          crossAxisAlignment:
              CrossAxisAlignment.stretch, //adjust its look hoizontally.
          children: [
            //Note: Card will assume the size of its child unless you specify for it to be bigger with a container (either wrap the card with a container with set width or do it to its child).
            //we are going to wrap this in a container to give it responsive height, and make it account for the appBars height info too.
            //notice we need to deduct the appBar height and status bar (via .of(context.padding.top)) height from both/all of these to make sure its right.
            Container(
              child: Chart(_recentTransactions),
              //use the MediaQuery class to dynamically find the size of the device this app is running on,
              // if you end with .size.height or .width, it will take 100% so multiple by a fraction you desire to get the relative size you want, between 0 and 1.

              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionList(_userTransactions, _deleteTransaction),
            ), //don't worry about the args, this is just passing a pointer to the function
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
