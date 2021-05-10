import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      child: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.play, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (this.controller.value == 0.0) {
            this.controller.forward();
            Future.delayed(Duration(milliseconds: 500), this.widget.onPressed);
          }
        },
      ),
      controller: this.controller,
      onPressed: () {},
    );
  }
}