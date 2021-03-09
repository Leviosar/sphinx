import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

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
        if (!game.hasData) return Container();
        
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Container(child: Text(game.data.start.toString()))
        );
      },
    );
  }
}