import 'package:json_annotation/json_annotation.dart';
import 'package:sphinx/models/game.dart';

import 'user.dart';

part 'challenge.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Challenge {

  DateTime startetAt;
  
  User challengerUser;
  User challengedUser;

  @JsonKey(nullable: true)
  Game challengerGame;
  @JsonKey(nullable: true)
  Game challengedGame;

  Challenge({this.challengerUser, this.challengedUser, this.challengerGame, this.challengedGame, this.startetAt});

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeToJson(this);

  bool get finished => this.challengerGame != null && this.challengedGame != null;

  bool amIChallenger(User user) => this.challengerUser.id == user.id;
  
  bool amIChallenged(User user) => this.challengedUser.id == user.id;
}