import 'package:contatosapp/models/contatos_model.dart';
import 'package:contatosapp/repositories/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContatosRepository {
  var _dio = Dio();

  void customDio() {
    _dio.options.headers["X-Parse-Application-Id"] =
        dotenv.get("HEADERSPARSEAPLICATTION");
    _dio.options.headers["X-Parse-REST-API-Key"] =
        dotenv.get("HEADERPARSERESTAPI");
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BASEURL");
  }

  Future<void> cadastrarContato(ContatoModel contatoModel) async {
    try {
      customDio();
      var result = await _dio.post("/Contatos", data: contatoModel.toJson());
      print(result.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<ContatosModel> obterContatos() async {
    try {
      customDio();
      var result = await _dio.get("/Contatos");
      if (result.statusCode == 200) {
        return ContatosModel.fromJson(result.data);
      }
      return ContatosModel([]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removerContato(String objectId) async {
    customDio();
    await _dio.delete("/Contatos/$objectId");
  }
}
