import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/game_modes.dart';
import '../create_game/create_game_page.dart';

class GameModeSelection extends StatefulWidget {
  @override
  _GameModeSelectionState createState() => _GameModeSelectionState();
}

class _GameModeSelectionState extends State<GameModeSelection> {

  Map<GameModes, IconData> icons = {
    GameModes.zen: FontAwesomeIcons.yinYang,
    GameModes.arcade: FontAwesomeIcons.gamepad,
    GameModes.challenge: FontAwesomeIcons.userFriends,
    GameModes.ultraRapidFurious: FontAwesomeIcons.stopwatch
  };

  Map<GameModes, String> titles = {
    GameModes.zen: "Zen",
    GameModes.arcade: "Arcade",
    GameModes.challenge: "Challenge",
    GameModes.ultraRapidFurious: "Time Attack"
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButton(
              onPressed: () => this.openCreateGamePage(context, GameModes.values[index]), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FaIcon(this.icons[GameModes.values[index]], color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(this.titles[GameModes.values[index]].toUpperCase(), style: TextStyle(fontSize: 16.0)),
                  ),
                ],
              )
            )
          ), 
          scrollDirection: Axis.horizontal,
          itemCount: 4
        ),
      ),
    );
  }

  openCreateGamePage(BuildContext context, GameModes mode) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreateGamePage(mode)));
  }
}