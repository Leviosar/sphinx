import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

import '../models/user.dart';
import 'BaseRequest.dart';

class GetCategoriesRequest implements BaseRequest {

  final User user;
  final String url = "http://joaomaia.me:5000/categories";

  GetCategoriesRequest(this.user);

  Future<http.Response> send() {
    return HttpWithInterceptor.build(interceptors: []).get(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${this.user.token.accessToken}'
      }
    );
  }
}