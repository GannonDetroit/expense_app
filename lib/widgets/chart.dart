import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';

import '../models/transactions.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  //an array of objects with string keys and object values, its a getter to initilize the value from dynamic data.
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      //this subtract is way for us to dynamically figure out the 'last 7 days'
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      //loop through all the transactions and sum them up for each day of the week
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      //using the intl package we can do dateformat.e to get the weekday we want.
      //substring is a dart function, it so I only take the first letter of each day of the week for style purposes.
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  //calculate the spendingPercentOfTotal
  double get totalSpending {
    //fold, from dart, allows us to change a list to a different data type. in this case a double
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            //                                           using the amount, turning it into a double and dividing by totalSpending to get the percent amount
            //the flixbile widget takes a fit arg (loose is default, so we almost always use will tight) and forces it to use its availabe space instead of screwing up other widgets.
            //you could also use the flex: key and give one widget 1 and another 2, flutter will add it and give the object with weight two 2/3rds of the space and the 1 only 1/3 of the space. You can make the ratios whatever.
            //you could also do Expanded(flex: value) since its basically just Flexible with FlexFit.tight, but less verbose.
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  //check to see if spending is zero (no transaction) and if so, set it to zero to avoid a bug, if not zero divide to get the percentage we want.
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
