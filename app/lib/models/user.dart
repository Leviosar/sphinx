import 'package:json_annotation/json_annotation.dart';

import 'token.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String id;
  String email;
  String name;
  String photo;

  @JsonKey(nullable: true)
  Token token;

  User({this.id, this.email, this.name, this.photo, this.token});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}