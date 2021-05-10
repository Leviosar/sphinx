import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'BaseRequest.dart';

class SearchUsers implements BaseRequest {

  final String query;
  final String url = "${env["API_BASE_URL"]}/user/email";

  SearchUsers([this.query = ""]);

  Future<http.Response> send() {
    return HttpWithInterceptor.build(interceptors: []).get(
      "$url?email=$query",
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${this.user.token.accessToken}'
      }
    );
  }
}