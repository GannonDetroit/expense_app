import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  final titleController =
      TextEditingController(); //controllers listen to user input and save it. Flutter likes this in stateless widgets over using onChange and saving to a variable.
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextButton(
                onPressed: () {
                  addTransaction();
                },
                child: Text('Add Transaction'),
                style: TextButton.styleFrom(primary: Colors.purple)),
          ],
        ),
      ),
    );
  }
}
