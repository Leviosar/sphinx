// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) {
  return Option(
    id: json['id'] as int,
    idQuestion: json['question_id'] as int,
    text: json['text'] as String,
  )..correct = json['correct'] as bool;
}

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'correct': instance.correct,
      'text': instance.text,
      'id': instance.id,
      'question_id': instance.idQuestion,
    };
