import 'package:json_annotation/json_annotation.dart';

import 'option.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  int id;

  @JsonKey(name: 'category_id')
  int idCategory;
  
  @JsonKey(name: 'answer_id')
  int idAnswer;

  String text;
  
  List<Option> options;

  Question({this.id, this.idCategory, this.text});

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}