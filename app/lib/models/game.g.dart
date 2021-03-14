// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    playerId: json['playerId'] as String,
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
    categories: (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dificulty: _$enumDecodeNullable(_$DificultyEnumMap, json['dificulty']),
    mode: _$enumDecodeNullable(_$GameModesEnumMap, json['mode']),
  )..questions = (json['questions'] as List)
      ?.map((e) =>
          e == null ? null : Question.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'playerId': instance.playerId,
      'start': instance.start?.toIso8601String(),
      'categories': instance.categories?.map((e) => e?.toJson())?.toList(),
      'questions': instance.questions?.map((e) => e?.toJson())?.toList(),
      'dificulty': _$DificultyEnumMap[instance.dificulty],
      'mode': _$GameModesEnumMap[instance.mode],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DificultyEnumMap = {
  Dificulty.rookie: 'rookie',
  Dificulty.adept: 'adept',
  Dificulty.veteran: 'veteran',
  Dificulty.master: 'master',
};

const _$GameModesEnumMap = {
  GameModes.arcade: 'arcade',
  GameModes.zen: 'zen',
  GameModes.challenge: 'challenge',
  GameModes.ultraRapidFurious: 'ultraRapidFurious',
};
