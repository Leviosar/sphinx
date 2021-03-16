import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:sphinx/controllers/user_bloc.dart';
import 'package:sphinx/models/question.dart';
import 'package:sphinx/models/user.dart';
import 'package:sphinx/requests/GetQuestionsByCategoryRequest.dart';

import '../../controllers/game_bloc.dart';
import '../../helpers/string_extension.dart';
import '../../models/category.dart';
import '../../models/game.dart';
import '../../models/game_modes.dart';
import '../game/game_page.dart';
import 'category_listing.dart';
import 'create_game_button.dart';
import 'dificulty_selector.dart';
import 'package:http/http.dart' as http;

class CreateGamePage extends StatefulWidget {

  final GameModes mode;

  CreateGamePage(this.mode);

  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {

  List<Category> categories;
  Dificulty dificulty;

  createGame() async {
    User user = await BlocProvider.getBloc<UserBloc>().getUser.first;
    Game game = Game(playerId: user.id, categories: this.categories, dificulty: this.dificulty, mode: this.widget.mode, start: DateTime.now());
    
    http.Response response = await GetQuestionsByCategoryRequest(user, categories).send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Question> questions = [];

      for (var question in data["data"]) {
        questions.add(Question.fromJson(question));
      }
      
      game.questions = questions;

      BlocProvider.getBloc<GameBloc>().currentGame = game;
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => GamePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.mode.toString().split('.').last.capitalize())),
      floatingActionButton: CreateGameButton(
        onPressed: this.createGame,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CategoryListing(onSelected: (List<Category> value) => this.categories = value)),
          SliverToBoxAdapter(child: DificultySelector(onChanged: (Dificulty value) => this.dificulty = value))
        ],
      )
    );
  }
}