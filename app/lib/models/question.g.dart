// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    id: json['id'] as int,
    idCategory: json['idCategory'] as int,
    text: json['text'] as String,
  )..options = json['options'] as List;
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'idCategory': instance.idCategory,
      'text': instance.text,
      'options': instance.options,
    };
