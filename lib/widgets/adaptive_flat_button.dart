import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final Function handler;
  AdaptiveTextButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            // color: Colors.blue, //Use this to give it a background and make it look like an Elevated Button, default looks like a TextButton
            child: Text(text),
            onPressed: handler,
          )
        : TextButton(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(
              primary: Theme.of(context).colorScheme.primary,
            ),
            onPressed: handler,
          );
  }
}
