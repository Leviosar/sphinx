import 'package:json_annotation/json_annotation.dart';

part 'option.g.dart';

@JsonSerializable()
class Option {
  int id;
  int idQuestion;
  bool correct;
  String text;

  Option({this.id, this.idQuestion, this.text});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}