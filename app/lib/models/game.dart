import 'package:json_annotation/json_annotation.dart';
import 'package:sphinx/models/question.dart';

import '../views/create_game/dificulty_selector.dart';
import 'category.dart';
import 'game_modes.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game {
  String playerId;
  DateTime start;
  List<Category> categories;
  List<Question> questions;
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