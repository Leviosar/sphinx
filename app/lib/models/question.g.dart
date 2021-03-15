// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    id: json['id'] as int,
    idCategory: json['category_id'] as int,
    text: json['text'] as String,
  )
    ..idAnswer = json['answer_id'] as int
    ..options = (json['options'] as List)
        ?.map((e) =>
            e == null ? null : Option.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'category_id': instance.idCategory,
      'answer_id': instance.idAnswer,
      'text': instance.text,
      'options': instance.options?.map((e) => e?.toJson())?.toList(),
    };
