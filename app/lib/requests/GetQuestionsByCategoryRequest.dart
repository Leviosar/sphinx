import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sphinx/models/category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/user.dart';
import 'BaseRequest.dart';

class GetQuestionsByCategoryRequest implements BaseRequest {

  final User user;
  final int limit;
  final List<Category> categories;
  final String url = "${env["API_BASE_URL"]}/questions";

  GetQuestionsByCategoryRequest(this.user, this.categories, { this.limit = 15 });

  Future<http.Response> send() {
    return HttpWithInterceptor.build(interceptors: []).post(
      url,
      body: jsonEncode({
        "categories": this.categories.map((el) => el.id).toList(),
        "limit": limit
      }),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${this.user.token.accessToken}'
      }
    );
  }
}