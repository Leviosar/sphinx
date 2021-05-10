import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/user.dart';
import 'BaseRequest.dart';

class GetRankingRequest implements BaseRequest {

  final User user;
  final String url = "${env["API_BASE_URL"]}/ranking?limit=5";
  List<int> categories;

  GetRankingRequest(this.user, [this.categories = const []]) {
    this.categories = this.categories.where((element) => element != 0).toList();
  }

  Future<http.Response> send() {
    return HttpWithInterceptor.build(interceptors: []).post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${this.user.token.accessToken}'
      },
      body: jsonEncode({
        "categories": this.categories
      })
    );
  }
}