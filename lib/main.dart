import 'package:contatosapp/my_app.dart';
import 'package:contatosapp/repositories/contatos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  getIt.registerSingleton<ContatosRepository>(ContatosRepository());

  runApp(const MyApp());
}
