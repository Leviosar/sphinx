import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/user.dart';
import 'BaseRequest.dart';

class RegisterUser implements BaseRequest {

  final User user;
  final String url = "${env["API_BASE_URL"]}/register";

  RegisterUser(this.user);

  Future<http.Response> send() {
    return HttpWithInterceptor.build(interceptors: []).post(
      url,
      body: jsonEncode({
        "id": this.user.id,
        "name": this.user.name,
        "email": this.user.email,
        "photo": this.user.photo,
      }),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${this.user.token.accessToken}'
      }
    );
  }
}