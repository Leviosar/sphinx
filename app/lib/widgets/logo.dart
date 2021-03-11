import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  
  final double width;

  Logo({this.width = 200.0});
  
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo.png', width: this.width);
  }

}