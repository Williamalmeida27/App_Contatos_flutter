import 'package:contatosapp/models/contatos_model.dart';
import 'package:contatosapp/repositories/custom_dio.dart';
import 'package:get/get.dart';

class ContatosRepository {
  var _customDio = CustomDio();

  Future<void> cadastrarContato(ContatoModel contatoModel) async {
    try {
      await _customDio.dio.post("/Contatos", data: contatoModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<ContatosModel> obterContatos() async {
    try {
      var result = await _customDio.dio.get("/Contatos");
      if (result.statusCode == 200) {
        return ContatosModel.fromJson(result.data);
      }
      return ContatosModel(<ContatoModel>[].obs);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removerContato(String objectId) async {
    await _customDio.dio.delete("/Contatos/$objectId");
  }
}
