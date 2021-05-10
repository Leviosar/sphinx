import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sphinx/models/game.dart';

import 'BaseRequest.dart';

class DeleteGame implements BaseRequest {

  final Game game;
  final String url = "${env["API_BASE_URL"]}/games";

  DeleteGame(this.game);

  Future<http.Response> send() {
    return HttpWithInterceptor.build(interceptors: []).delete(
      "$url/${this.game.id}",
      headers: {
        'Content-Type': 'application/json',
      }
    );
  }
}