import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentOfTotal);

  @override
  Widget build(BuildContext context) {
    //LayoutBuilder allows me to leverage constraints to help add dynamic responive heights and width to the widget(s)
    //constraint is used in flutter to specify how much space a widget may take and how they are rendered on the screen. height and width can be 0 < whatever you want < infinity. all widgets have a default one if you don't specify
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            //fittedbox forces its child into the aviable space, even shrinking the text font size dynamically.
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              //a stack allows you to put widgets overlapped on top of each other. first element is bottom and last is on top.
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  //This is a container with a fractional height of a parent value(the container with height 60 in this example), helps to keep aspect ratios for design purposes, height factor is the between 0-1, where 1 = 100% parent height value
                  FractionallySizedBox(
                    heightFactor: spendingPercentOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              //using FittedBox just incase the user device is really small, the text will be resized to still be readable and fit in the box.
              child: FittedBox(child: Text(label)),
              height: constraints.maxHeight * 0.15,
            ),
          ],
        );
      },
    );
  }
}
