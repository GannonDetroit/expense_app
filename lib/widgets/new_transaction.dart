import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransaction;

  final titleController =
      TextEditingController(); //controllers listen to user input and save it. Flutter likes this in stateless widgets over using onChange and saving to a variable.
  final amountController = TextEditingController();

  NewTransaction(this.addTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            TextButton(
                onPressed: () {
                  addTransaction(titleController.text,
                      double.parse(amountController.text));
                },
                child: Text('Add Transaction'),
                style: TextButton.styleFrom(primary: Colors.purple)),
          ],
        ),
      ),
    );
  }
}
