import 'package:flutter/material.dart';

//changed to a stateful widget even though I don't use state because it will maintain the inputted data, when this was stateless it would not
//keep the data when entered into the textfields when I switched to the other textfields because of re-rendering aspects of flutter internals.
//TL;DR if there are inputs.... make it stateful, even if not using state.
class NewTransaction extends StatefulWidget {
  NewTransaction(this.addTransaction);

  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void SubmitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //doing an empty return because it literally does nothing.
    } else {
      //this widget. came from the refactor effect, it allows me access to properties and methods in the top widget class from this stateclass, since
      //these are technically two seperate classes.... this is how we share info between them and thus bow I can access the addTransaction method in here.
      widget.addTransaction(enteredTitle, enteredAmount);
    }
    //how we auto close the widget on submission, again context is just meta data for flutter intenals.
    Navigator.of(context).pop();
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
                style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor)),
          ],
        ),
      ),
    );
  }
}
