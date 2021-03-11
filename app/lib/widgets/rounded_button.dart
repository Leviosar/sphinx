import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  
  final Widget child;
  final Function onPressed;
  final double radius;
  final double width;
  final double height;

  RoundedButton({this.radius = 100.0, this.onPressed, this.child, this.width = 300, this.height = 50});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: this.child,
      onPressed: this.onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size(this.width, this.height)
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(this.radius)) 
          )
        )
      ),
    );
  }
}