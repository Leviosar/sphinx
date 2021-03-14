import 'dart:math';

import 'package:flutter/material.dart';

class ExpansionAnimatedButton extends AnimatedWidget {

  final Widget child;
  final Function onPressed;

  ExpansionAnimatedButton({this.child, this.onPressed, controller}) : super(listenable: controller);

  Animation<double> get width => listenable;

  @override
  Widget build(BuildContext context) {
    double tickSize = 60 + (1500 * this.width.drive(CurveTween(curve: Curves.easeInExpo)).value);

    return Padding(
      padding: EdgeInsets.all(max(0, 10.0 - (0.01 * tickSize))),
      child: InkWell(
        onTap: this.onPressed,
        child: Container(
          child: tickSize != 60 ? 
            Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 50,
                width: 50
              ),
            ) : 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                this.child
              ],
            ), 
          width: tickSize,
          height: tickSize, 
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(1560 - tickSize))
          )
        )
      ),
    );
  }
}
