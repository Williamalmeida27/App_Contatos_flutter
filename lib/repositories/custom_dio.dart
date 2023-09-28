import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDio {
  var _dio = Dio();

  get dio => _dio;

  CustomDio() {
    _dio.options.headers["X-Parse-Application-Id"] =
        dotenv.get("HEADERSPARSEAPLICATTION");
    _dio.options.headers["X-Parse-REST-API-Key"] =
        dotenv.get("HEADERPARSERESTAPI");
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BASEURL");
  }
}
