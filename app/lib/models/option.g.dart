// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) {
  return Option(
    id: json['id'] as int,
    idQuestion: json['idQuestion'] as int,
    text: json['text'] as String,
  )..correct = json['correct'] as bool;
}

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'id': instance.id,
      'idQuestion': instance.idQuestion,
      'correct': instance.correct,
      'text': instance.text,
    };
