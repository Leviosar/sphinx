import 'package:flutter/material.dart';
import '../../widgets/side_banner.dart';
import '../../helpers/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

enum Dificulty {
  @JsonValue('rookie') rookie,
  @JsonValue('adept') adept,
  @JsonValue('veteran') veteran,
  @JsonValue('master') master
}

typedef DificultySelectorCallback = Function(Dificulty value);

class DificultySelector extends StatefulWidget {

  final DificultySelectorCallback onChanged;

  const DificultySelector({Key key, this.onChanged}) : super(key: key);

  @override
  _DificultySelectorState createState() => _DificultySelectorState();
}

class _DificultySelectorState extends State<DificultySelector> {
  int dificultyValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SideBanner(title: 'Dificulty', direction: SideBannerDirection.right),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Slider(
                min: 0.0,
                max: 3.0,
                divisions: 3,
                value: dificultyValue.toDouble(), 
                onChanged: (double value) {
                  setState(() {
                    this.dificultyValue = value.toInt();
                  });
                }
              ),
            )
          ],
        ),
        Text(Dificulty.values[this.dificultyValue].toString().split('.').last.capitalize())
      ]
    );
  }
}