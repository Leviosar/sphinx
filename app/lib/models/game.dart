import 'package:json_annotation/json_annotation.dart';

import '../views/create_game/dificulty_selector.dart';
import 'category.dart';
import 'game_modes.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game {
  int playerId;
  DateTime start;
  List<Category> categories;
  Dificulty dificulty;
  GameModes mode;

  Game({
    this.playerId, 
    this.start,
    this.categories,
    this.dificulty,
    this.mode
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}