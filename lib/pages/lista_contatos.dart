import 'dart:io';

import 'package:contatosapp/models/contatos_model.dart';
import 'package:contatosapp/repositories/contatos_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({super.key});

  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  late ContatosRepository contatosRepository;
  var _listContatos = ContatosModel([]);
  bool loading = false;
  bool remover = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    setState(() {
      loading = true;
    });
    contatosRepository = ContatosRepository();
    _listContatos = await contatosRepository.obterContatos();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Contatos"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _listContatos.contatos!.length,
            itemBuilder: (_, index) {
              var contato = _listContatos.contatos![index];
              return Column(
                children: [
                  loading == true
                      ? const Center(child: CircularProgressIndicator())
                      : Row(
                          children: [
                            Container(
                              height: 55,
                              width: 60,
                              child: CircleAvatar(
                                backgroundImage:
                                    FileImage(File(contato.urlImagem)),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(contato.nome),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(contato.telefone.toString()),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Center(
                                    child:
                                        const FaIcon(FontAwesomeIcons.trash)),
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return Dialog(
                                          child: Wrap(
                                            children: [
                                              const Center(
                                                  child:
                                                      Text("Deseja Remover?")),
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        await contatosRepository
                                                            .removerContato(
                                                                contato
                                                                    .objectId);
                                                        Navigator.pop(context);
                                                        carregarDados();
                                                      },
                                                      child: const Column(
                                                        children: [
                                                          Text("Sim"),
                                                          FaIcon(
                                                              FontAwesomeIcons
                                                                  .remove),
                                                        ],
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          remover = false;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Column(
                                                        children: [
                                                          Text("Não"),
                                                          FaIcon(
                                                              FontAwesomeIcons
                                                                  .cancel),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                              ),
                            ),
                          ],
                        )
                ],
              );
            }),
      ),
    ));
  }
}
