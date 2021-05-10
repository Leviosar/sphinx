import 'package:flutter/material.dart';
import 'package:sphinx/models/game.dart';

class GameOverPage extends StatefulWidget {

  final Game game;
  final double scoredPoints;

  const GameOverPage({Key key, this.game, this.scoredPoints}) : super(key: key);

  @override
  _GameOverPageState createState() => _GameOverPageState();
}

class _GameOverPageState extends State<GameOverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Good job bro!"),
            Text(
              "${(this.widget.scoredPoints ~/ 10)} / ${this.widget.game.questions.length}", 
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 32.0)
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
                  ),
                  onPressed: () {}, 
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    ],
                  )
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
                  ),
                  onPressed: () {}, 
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ],
                  )
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
                  ),
                  onPressed: () {}, 
                  child: Row(
                    children: [
                      Icon(
                        Icons.repeat,
                        color: Colors.white,
                      ),
                    ],
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}