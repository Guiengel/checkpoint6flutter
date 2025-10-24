import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerador_de_senha/firebase_options.dart';
import 'package:gerador_de_senha/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gerador de senhas",
      theme: ThemeData.dark(),
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
