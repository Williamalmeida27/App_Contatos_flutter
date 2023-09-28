class ContatosModel {
  List<ContatoModel>? contatos = [];

  ContatosModel(this.contatos);

  ContatosModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contatos = <ContatoModel>[];
      json['results'].forEach((v) {
        contatos!.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (contatos != null) {
      data['results'] = contatos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContatoModel {
  String objectId = '';
  String nome = "";
  int telefone = 0;
  String urlImagem = "";

  ContatoModel(this.nome, this.telefone, this.urlImagem);
  ContatoModel.vazio();

  ContatoModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    nome = json['Nome'];
    telefone = json['Telefone'];
    urlImagem = json['Url_imagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = objectId;
    data['Nome'] = this.nome;
    data['Telefone'] = this.telefone;
    data['Url_imagem'] = this.urlImagem;
    return data;
  }
}
