import 'package:contatosapp/pages/lista_contatos.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            width: double.infinity,
            child: const Row(
              children: [
                FaIcon(FontAwesomeIcons.userPlus),
                SizedBox(
                  width: 25,
                ),
                Text("Adicionar Contato")
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            width: double.infinity,
            child: const Row(
              children: [
                FaIcon(FontAwesomeIcons.clipboardList),
                SizedBox(
                  width: 25,
                ),
                Text("Lista de Contatos")
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ListaContatos()));
          },
        )
      ]),
    );
  }
}
