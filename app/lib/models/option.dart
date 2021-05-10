import 'package:json_annotation/json_annotation.dart';

part 'option.g.dart';

@JsonSerializable()
class Option {
  bool correct;
  
  String text;

  int id;

  @JsonKey(name: 'question_id')
  int idQuestion;

  Option({this.id, this.idQuestion, this.text});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}