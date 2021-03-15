import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:sphinx/views/game/question_display.dart';

import '../../controllers/game_bloc.dart';
import '../../models/game.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.getBloc<GameBloc>().getCurrentGame,
      builder: (BuildContext context, AsyncSnapshot<Game> game) {
        if (!game.hasData) return Center();
        
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: QuestionDisplay(game: game.data),
            ) 
          )
        );
      },
    );
  }
}