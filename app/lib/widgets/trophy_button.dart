import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrophyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          border: Border.all(color: Color(0xffd9c11f), width: 2.0)
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              FaIcon(FontAwesomeIcons.trophy, color: Color(0xffd9c11f), size: 32.0),
              Container(
                height: 16.0,
                width: 16.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                child: Center(child: Text("3")),
              )
            ],
          ),
        )
      )
    );
  }
}