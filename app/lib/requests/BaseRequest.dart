import 'package:http/http.dart' as http;

abstract class BaseRequest {
  Future<http.Response> send();
}