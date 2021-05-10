// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Challenge _$ChallengeFromJson(Map<String, dynamic> json) {
  return Challenge(
    challengerUser: json['challenger_user'] == null
        ? null
        : User.fromJson(json['challenger_user'] as Map<String, dynamic>),
    challengedUser: json['challenged_user'] == null
        ? null
        : User.fromJson(json['challenged_user'] as Map<String, dynamic>),
    challengerGame: json['challenger_game'] == null
        ? null
        : Game.fromJson(json['challenger_game'] as Map<String, dynamic>),
    challengedGame: json['challenged_game'] == null
        ? null
        : Game.fromJson(json['challenged_game'] as Map<String, dynamic>),
    startetAt: json['startet_at'] == null
        ? null
        : DateTime.parse(json['startet_at'] as String),
  );
}

Map<String, dynamic> _$ChallengeToJson(Challenge instance) => <String, dynamic>{
      'startet_at': instance.startetAt?.toIso8601String(),
      'challenger_user': instance.challengerUser?.toJson(),
      'challenged_user': instance.challengedUser?.toJson(),
      'challenger_game': instance.challengerGame?.toJson(),
      'challenged_game': instance.challengedGame?.toJson(),
    };
