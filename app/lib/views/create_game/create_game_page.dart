import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sphinx/controllers/user_bloc.dart';
import 'package:sphinx/models/question.dart';
import 'package:sphinx/models/user.dart';
import 'package:sphinx/requests/GetQuestionsByCategoryRequest.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sphinx/views/create_game/oponent_selector.dart';

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
  User oponent;

  CarouselController controller = CarouselController();

  int totalSteps = 2;
  int currentStep = 0;

  bool get isLastStep => this.totalSteps - 1 == this.currentStep;

  @override
  initState() {
    super.initState();

    switch (this.widget.mode) {
      case GameModes.challenge:
        this.totalSteps = 3;
        break;
      case GameModes.zen:
        this.totalSteps = 1;
        break;
      default:
        this.totalSteps = 2;
    }
  }

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
      floatingActionButton: this.buildActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: LinearProgressIndicator(value: this.currentStep / this.totalSteps)),
          SliverToBoxAdapter(child: this.buildCarousel(context)),
        ],
      )
    );
  }

  Widget buildActionButton() {
    if (this.isLastStep) {
      return CreateGameButton(
        onPressed: this.createGame,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          child: FaIcon(FontAwesomeIcons.arrowRight, color: Colors.white),
          onPressed: () => this.controller.nextPage(),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
  }

  Widget buildCarousel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: CarouselSlider(
        carouselController: this.controller,
        items: [
          CategoryListing(onSelected: (List<Category> value) => this.categories = value),
          ... this.widget.mode != GameModes.zen ? [DificultySelector(onChanged: (Dificulty value) => this.dificulty = value)] : [],
          ... this.widget.mode == GameModes.challenge ? [OponentSelector(onChanged: (User user) => this.oponent = user)] : []
        ], 
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.8,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          onPageChanged: (int page, CarouselPageChangedReason event) {
            setState(() {
              currentStep = page;          
            });
          }
        )
      ),
    );
  }
}