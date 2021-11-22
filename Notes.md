NOTE: using ListView with children will render ALL children widgets, if you have hundreds of them it will murder you efficiency. So you use ListView.builder(), which will only load what widgets are currently visible!


          // spread operator solves a bug about a list of widgets not working with map
          // to put a dynamic amount of objects in a column use map and return whatever widget you want but add .toList() at the end.

when making a number keyboard options do this:
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true), //reason we do this is sometimes iOS wont' allow for decimal, so this Option version avoids bugs
            ),

