import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction(this.addTransaction);

  final Function addTransaction;
  final titleController =
      TextEditingController(); //controllers listen to user input and save it. Flutter likes this in stateless widgets over using onChange and saving to a variable.
  final amountController = TextEditingController();

  void SubmitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //doing an empty return because it literally does nothing.
    } else {
      addTransaction(enteredTitle, enteredAmount);
    }
  }

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
              onSubmitted: (_) =>
                  SubmitData(), //need to have _ , just because of how onSubmitted works it needs a 'value' so _ is a convention for showing its nothing, even though its a void function.
              keyboardType: TextInputType.numberWithOptions(
                  decimal:
                      true), //reason we do this is sometimes iOS wont' allow for decimal, so this Option version avoids bugs
            ),
            TextButton(
                onPressed: SubmitData,
                child: Text('Add Transaction'),
                style: TextButton.styleFrom(primary: Colors.purple)),
          ],
        ),
      ),
    );
  }
}
