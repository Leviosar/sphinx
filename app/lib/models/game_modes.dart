import 'package:json_annotation/json_annotation.dart';

enum GameModes {
  @JsonValue('arcade') arcade,
  @JsonValue('zen') zen,
  @JsonValue('challenge') challenge,
  @JsonValue('ultraRapidFurious') ultraRapidFurious
}