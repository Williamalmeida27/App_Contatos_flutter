import 'package:get/get.dart';

class ContatosModel extends GetxController {
  RxList<ContatoModel> _contatos = <ContatoModel>[].obs;

  List<ContatoModel> get contatos => _contatos.toList();

  ContatosModel(this._contatos);

  ContatosModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      _contatos = <ContatoModel>[].obs;
      json['results'].forEach((v) {
        _contatos.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = _contatos.map((v) => v.toJson()).toList();
    return data;
  }
}

class ContatoModel {
  String? objectId;
  String? nome;
  int? telefone;
  String? urlImagem;

  ContatoModel(this.nome, this.telefone, this.urlImagem);
  ContatoModel.vazio();

  ContatoModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    nome = json['Nome'];
    telefone = json['Telefone'];
    urlImagem = json['Url_imagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['Nome'] = nome;
    data['Telefone'] = telefone;
    data['Url_imagem'] = urlImagem;
    return data;
  }
}
