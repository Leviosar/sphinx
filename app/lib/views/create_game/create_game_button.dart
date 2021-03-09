import 'package:flutter/material.dart';

import '../../widgets/expansion_animated_button.dart';

class CreateGameButton extends StatefulWidget {

  final Function onPressed;

  const CreateGameButton({Key key, this.onPressed}) : super(key: key);

  @override
  _CreateGameButtonState createState() => _CreateGameButtonState();
}

class _CreateGameButtonState extends State<CreateGameButton> with SingleTickerProviderStateMixin{
  
  AnimationController controller;

  @override
  void initState() {
    this.controller = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 500),
    );

    this.controller.value = 0.0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionAnimatedButton(
      child: Icon(Icons.play_arrow, color: Colors.white),
      controller: this.controller,
      onPressed: () {
        if (this.controller.value == 0.0) {
          this.controller.forward();
          Future.delayed(Duration(milliseconds: 500), this.widget.onPressed);
        }
      },
    );
  }
}