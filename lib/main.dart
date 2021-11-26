// ignore_for_file: use_key_in_widget_constructors
import 'dart:io';
import 'package:flutter/cupertino.dart';
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
    //you might want to do Platform.isiOS ? CupertinoApp() : MaterialApp() but note that CupertinoApp has different theme options and stuff than the MaterialApp, so i'm skipping it for this project to save time since MaterailApp CAN work on iOS that just can have some odd quirks every now and again (mainly for navigation reasons), which don't affect this app.
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

  bool _showChart = false;

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
    //just putting in a variable as a shortcut because of how many times I call MediaQuery
    final mediaQuery = MediaQuery.of(context);
    //how to determine device orientation, make final so its only triggered whenever flutter rebuilds the UI.
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    //storing the AppBar widget in this appBar variable because doing it this way allows the appBar varible to be assisible anywhere most importantly
    //gives me information about its height, which I can use for helping make my app more responsive and adapative.
    //specifying PreferredSizeWidgets avoid a bug with CupertinoNavigation not understanding appBar is PreferredSizeWidget, so we have to state it explicitly.
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              //mainAxisSize prevents row and column from taking max size possible and add a restriction
              mainAxisSize: MainAxisSize.min,
              children: [
                //IconButton is a materail UI thing, so this way is like making a custom Icon Button for iOS.
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            actions: [
              IconButton(
                  onPressed: () => _startAddNewTransaction(context),
                  icon: Icon(Icons.add))
            ],
            title: const Text(
              'Personal Expenses',
            ),
          );
    //storing this widget in a variable to save on copy and pasting code, which would have resulted when we refactored to handle dynamic rendering based on if we are in landscape or portrait mode.
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    ); //don't worry about the args, this is just passing a pointer to the function

    //SafeArea is to help make sure everything is within the boundries of the reserved areas on iOS (like the top part that has the time and wifi symbol and bottom that has the app drawer line thing too)
    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.start, //adjust it's look vertically on screen.
        crossAxisAlignment:
            CrossAxisAlignment.stretch, //adjust its look hoizontally.
        children: [
          //use an if statement with NO {} as shorthand ternary expression for if a widget should or should not be rendered.
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                //value is just true or false, this toggle allows us to switch state to show or not show a widget.
                //using the .adaptive make it auto adapt its UI based on if its on iOS or Android with no other configuration needed.
                //many flutter widgets have this, check to docs to confirm which widgets do and do not.
                Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    }),
              ],
            ),
          //Note: Card will assume the size of its child unless you specify for it to be bigger with a container (either wrap the card with a container with set width or do it to its child).
          //we are going to wrap this in a container to give it responsive height, and make it account for the appBars height info too.
          //notice we need to deduct the appBar height and status bar (via .of(context.padding.top)) height from both/all of these to make sure its right.
          if (!isLandscape)
            Container(
              child: Chart(_recentTransactions),
              //use the MediaQuery class to dynamically find the size of the device this app is running on,
              // if you end with .size.height or .width, it will take 100% so multiple by a fraction you desire to get the relative size you want, between 0 and 1.

              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  .3,
            ),
          if (!isLandscape) txListWidget,

          if (isLandscape)
            //using a ternary to determine which widget to render
            _showChart
                ? Container(
                    child: Chart(_recentTransactions),
                    //use the MediaQuery class to dynamically find the size of the device this app is running on,
                    // if you end with .size.height or .width, it will take 100% so multiple by a fraction you desire to get the relative size you want, between 0 and 1.

                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        .7,
                  )
                : txListWidget
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            //Notice how floating action buttons are NOT in the body of this app, its also an Android only UI type thing, so just render an empty container if on iOS for style reasons.
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
