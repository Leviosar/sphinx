import 'package:flutter/material.dart';
import 'package:sphinx/models/option.dart';

class OptionButton extends StatefulWidget {
  
  final Option option;
  final int index;
  final Function onPressed;

  const OptionButton({Key key, this.option, this.index, this.onPressed}) : super(key: key);

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {

  List<String> letters = ["A", "B", "C", "D", "E", "F"];
  Option old;
  bool pressed = false;

  @override
  void initState() {
    this.old = this.widget.option;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    if (old.id != this.widget.option.id) {
      this.pressed = false;
      this.old = this.widget.option;
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (!this.pressed) {
                setState(() {
                  this.pressed = true;
                  this.widget.onPressed();
                });
              }
            }, 
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  this.pressed ? 
                  CircleAvatar(
                    backgroundColor: this.widget.option.correct ? Colors.green : Colors.red,
                    foregroundColor: Colors.white,
                    child: Icon(this.widget.option.correct ? Icons.check : Icons.close),
                  )
                  : 
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    child: Text(this.letters[this.widget.index]),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        this.widget.option.text,
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ) 
                  )
                ],
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100.0)))),
              padding: MaterialStateProperty.all(EdgeInsets.all(8.0))
            ),
          ),
        ),
      ],
    );
  }
}