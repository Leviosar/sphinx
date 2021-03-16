import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sphinx/models/game.dart';

import '../models/user.dart';
import 'BaseRequest.dart';

class StoreGameRequest implements BaseRequest {

  final User user;
  final Game game;
  final String url = "http://joaomaia.me:5000/games/register";

  StoreGameRequest(this.user, this.game);

  Future<http.Response> send() {
    return HttpWithInterceptor.build(interceptors: []).post(
      url,
      body: jsonEncode({
        "user_id": this.game.playerId,
        "start": this.game.start.toIso8601String(),
        "end": this.game.end.toIso8601String(),
        "points": this.game.points,
        "categories": this.game.categories.map((el) => el.id).toList(),
      }),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${this.user.token.accessToken}'
      }
    );
  }
}