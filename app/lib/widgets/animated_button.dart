import 'package:flutter/material.dart';

class AnimatedButton extends AnimatedWidget {

  final Widget child;
  final Function onPressed;

  AnimatedButton({this.child, this.onPressed, width}) : super(listenable: width);

  Animation<double> get width => listenable;

  @override
  Widget build(BuildContext context) {
    double tickWidth = 60 + (240 * this.width.drive(CurveTween(curve: Curves.bounceIn)).value);

    return InkWell(
      onTap: this.onPressed,
      child: Container(
        child: tickWidth == 60 ? 
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircularProgressIndicator(), 
          )
          : 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              this.child
            ],
          ), 
        width: tickWidth,
        height: 60, 
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(100))
        )
      )
    );
  }
}
