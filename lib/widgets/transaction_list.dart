import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transactions Yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                //if you don't provide a child to sizedbox, its common to give it just a height and/or width to be used as a spacer/seperator.
                SizedBox(
                  height: 20,
                ),
                //image can use asset, file, memory or network.
                //  asset is if its a file in our code.
                //  file is good when we get a file in a different way, like we socket stream it in or something along that line
                //  network is good when fetching via a URL.
                Container(
                  //boxfit.cover forces an image to fit into its parent size, but it was column which is infinite, so we added a container to give the image a forced size
                  height: 200,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              // ^^ essentailly a column with SingleChildScrollView but has nice built in features. has an infinite height so set it in something like a container with a height, or just make the whole app body a SingleChildScrollView.
              itemBuilder: (context, index) {
                //context and index are needed params for itemBuilder.
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        child: Text(
                          //This is how you can use string interpulation and how to show dollar signs since they are a reserved character in dart, so \$ to show them.
                          '\$ ${transactions[index].amount.toStringAsFixed(2)}', //toStringAsFixed(2) means it will be no more and no less than 2 decimal places
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat('MMM dd, yyyy')
                                .format(transactions[index].date),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
