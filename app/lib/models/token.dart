import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'expires_in')
  int expiresIn;
  @JsonKey(name: 'expiration_date')
  DateTime expirationDate;
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'type_token')
  String typeToken;

  Token({this.expiresIn, this.accessToken, this.refreshToken, this.typeToken, this.expirationDate}){
    this.setExpirationDate();
  }

  setExpirationDate() {
    DateTime now = DateTime.now();
    this.expirationDate = now.add(Duration(seconds: this.expiresIn));
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}