//this is just Dart, not really flutter and its just creating a class for Transaction objects, so not even a widget, just
//good old fashion OOP type stuff. HOWEVER, since I want to use the @required that IS a flutter thing, thus the import below.

import 'package:flutter/foundation.dart';

class Transaction {
  //properties: remember that final means they get and keep their values when the object is created at run time.
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  //constructor
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
