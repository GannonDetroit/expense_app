NOTE: using ListView with children will render ALL children widgets, if you have hundreds of them it will murder you efficiency. So you use ListView.builder(), which will only load what widgets are currently visible!


          // spread operator solves a bug about a list of widgets not working with map
          // to put a dynamic amount of objects in a column use map and return whatever widget you want but add .toList() at the end.

when making a number keyboard options do this:
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true), //reason we do this is sometimes iOS wont' allow for decimal, so this Option version avoids bugs
            ),

Working with the "textScaleFactor"
In this course, I mostly focus on the device sizes (height and width) when it comes to working with the MediaQuery class.

As mentioned, it offers way more than that of course. On particularly interesting property is the textScaleFactor property:

final curScaleFactor = MediaQuery.of(context).textScaleFactor;
textScaleFactor tells you by how much text output in the app should be scaled. Users can change this in their mobile phone / device settings.

Depending on your app, you might want to consider using this piece of information when setting font sizes.

Consider this example:

Text('Always the same size!', style: TextStyle(fontSize: 20));
This text ALWAYS has a size of 20 device pixels, no matter what the user changed in his / her device settings.

Text('This changes!', style: TextStyle(fontSize: 20 * curScaleFactor));
This text on the other hand also has a size of 20 if the user didn't change anything in the settings (because textScaleFactor by default is 1). But if changes were made, the font size of this text respects the user settings.