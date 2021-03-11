// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    expiresIn: json['expires_in'] as int,
    accessToken: json['access_token'] as String,
    refreshToken: json['refresh_token'] as String,
    typeToken: json['type_token'] as String,
    expirationDate: json['expiration_date'] == null
        ? null
        : DateTime.parse(json['expiration_date'] as String),
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'expires_in': instance.expiresIn,
      'expiration_date': instance.expirationDate?.toIso8601String(),
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'type_token': instance.typeToken,
    };
