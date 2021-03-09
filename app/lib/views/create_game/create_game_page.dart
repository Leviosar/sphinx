import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../controllers/game_bloc.dart';
import '../../helpers/string_extension.dart';
import '../../models/category.dart';
import '../../models/game.dart';
import '../../models/game_modes.dart';
import '../game/game_page.dart';
import 'category_listing.dart';
import 'create_game_button.dart';
import 'dificulty_selector.dart';

class CreateGamePage extends StatefulWidget {

  final GameModes mode;

  CreateGamePage(this.mode);

  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {

  List<Category> categories;
  Dificulty dificulty;

  createGame() {
    Game game = Game(categories: this.categories, dificulty: this.dificulty, mode: this.widget.mode, start: DateTime.now());
    BlocProvider.getBloc<GameBloc>().currentGame = game;
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => GamePage()));
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