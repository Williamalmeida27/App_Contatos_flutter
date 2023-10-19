import 'package:contatosapp/models/contatos_model.dart';
import 'package:contatosapp/repositories/contatos_repository.dart';
import 'package:contatosapp/shared/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  XFile? photo;

  var contato = ContatoModel.vazio();
  late ContatosRepository contatoRepository;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    carregarDados();
  }

  carregarDados() async {
    contatoRepository = ContatosRepository();
  }

  cropper(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      await ImageGallerySaver.saveFile(croppedFile.path);
      photo = XFile(croppedFile.path);
      setState(() {});
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("Contatos"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Nome:"),
          ),
          TextFormField(
            controller: nomeController,
            keyboardType: TextInputType.name,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Telefone:"),
          ),
          TextFormField(
            controller: telefoneController,
            keyboardType: TextInputType.number,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Imagem:"),
          ),
          TextFormField(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (_) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: const FaIcon(
                            FontAwesomeIcons.camera,
                            color: Colors.blueGrey,
                          ),
                          title: const Text("Camera"),
                          onTap: () async {
                            final _imagePicket = ImagePicker();
                            try {
                              XFile? file = await _imagePicket.pickImage(
                                  source: ImageSource.camera);
                              if (file != null) {
                                photo = file;
                                String path = (await path_provider
                                        .getApplicationDocumentsDirectory())
                                    .path;
                                String name = basename(photo!.path);
                                await photo!.saveTo("$path/$name");

                                await ImageGallerySaver.saveFile(photo!.path);
                                urlController.text = photo!.path;
                                Navigator.pop(context);
                              }
                              setState(() {});
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        ListTile(
                          leading: const FaIcon(
                            FontAwesomeIcons.imagePortrait,
                            color: Colors.lightBlue,
                          ),
                          title: const Text("Galeria"),
                          onTap: () async {
                            final _imagePicker = ImagePicker();
                            try {
                              photo = await _imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              urlController.text = photo!.path;
                              Navigator.pop(context);
                            } catch (e) {
                              rethrow;
                            }
                          },
                        )
                      ],
                    );
                  });
            },
            readOnly: true,
            controller: urlController,
            keyboardType: TextInputType.url,
          ),
          TextButton(
              onPressed: () {
                contato.nome = nomeController.text;
                if (telefoneController.text.isEmpty) {
                  contato.telefone = 0;
                } else {
                  contato.telefone = int.parse(telefoneController.text);
                }

                contato.urlImagem = urlController.text;

                if (nomeController.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("O nome não pode ser vazio")));
                  return;
                } else if (telefoneController.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("O telefone não pode ser vazio")));
                  return;
                }

                contatoRepository.cadastrarContato(contato);
                setState(() {
                  nomeController.text = "";
                  telefoneController.text = "";
                  urlController.text = "";
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Contato Salvo!"),
                  backgroundColor: Colors.purple,
                ));
                return;
              },
              child: const Text("Salvar"))
        ]),
      ),
    ));
  }
}
