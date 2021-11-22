import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime
      _selectedDate; //this is NOT final because its vaule can/will change with the date picker after this widget is initialized.

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    //data validation to make sure an amount is added to avoid a bug
    if (_amountController.text.isEmpty) {
      return;
    }
    //data validation to make sure a title, an amount over zero, and a date are selected to help avoid a bug.
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; //doing an empty return because it literally does nothing, like returning null.
    } else {
      //this widget. came from the refactor effect, it allows me access to properties and methods in the top widget class from this stateclass, since
      //these are technically two seperate classes.... this is how we share info between them and thus bow I can access the addTransaction method in here.
      widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);
    }
    //how we auto close the widget on submission, again context is just meta data for flutter intenals.
    Navigator.of(context).pop();
  }

//configures the date picker, a widget given to me by flutter, notice it returns a Future class with a DateTime object (Future is like an await in JS, commonly used in HTTP requests)
  void _presentDatePicker() {
    //unlike in JS, this program will NOT pause for the .then, it will store in memory the info, but if I did a Print() right after the .then it would NOT have the finished info in it, this is an unblocking .then
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return; //this blank return is like return null;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
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
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              onSubmitted: (_) =>
                  _submitData(), //need to have _ , just because of how onSubmitted works it needs a 'value' so _ is a convention for showing its nothing, even though its a void function.
              keyboardType: TextInputType.numberWithOptions(
                  decimal:
                      true), //reason we do this is sometimes iOS wont' allow for decimal, so this Option version avoids bugs
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: _submitData,
                child: Text(
                  'Add Transaction',
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    primary: Theme.of(context).textTheme.button.color)),
          ],
        ),
      ),
    );
  }
}
