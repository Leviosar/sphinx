import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sphinx/models/game.dart';
import 'package:sphinx/models/user.dart';
import 'package:sphinx/requests/GetGames.dart';
import 'package:http/http.dart' as http;
import 'package:sphinx/views/game_history/game_history_item.dart';

class GameHistoryList extends StatefulWidget {
  final User user;

  const GameHistoryList({Key key, this.user}) : super(key: key);

  @override
  _GameHistoryListState createState() => _GameHistoryListState();
}

class _GameHistoryListState extends State<GameHistoryList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetGames(this.widget.user).send(),
      builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
        if (!response.hasData) return Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)),
            ),
          ),
        );

        List<dynamic> data = jsonDecode(response.data.body);

        List<Game> games = List.generate(data.length, (index) => Game.fromJson(data[index]));

        List<Widget> children = List.generate(games.length, (index) => GameHistoryItem(
          game: games[index],
          index: index,
        ));

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: children,
          ),
        );
      }
    );
  }
}