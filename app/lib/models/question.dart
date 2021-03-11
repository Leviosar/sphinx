import 'package:json_annotation/json_annotation.dart';

import 'option.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  int id;
  int idCategory;
  String text;
  List<Option> options;

  Question({this.id, this.idCategory, this.text});

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}