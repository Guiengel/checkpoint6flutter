import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerador_de_senha/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  Future<void> _nextScreen() async {
  await Future.delayed(const Duration(milliseconds: 1400));
  // --- Diagnóstico das credenciais do APP ---
  final app = Firebase.app();
  final opts = app.options;
  print('APP -> projectId=${opts.projectId}  appId=${opts.appId}  apiKey=${opts.apiKey}');

  // --- Passo 1: tenta usar o usuário atual, se houver ---
  User? user = FirebaseAuth.instance.currentUser;
  print('Splash: currentUser (antes) = ${user?.uid}');

  if (user != null) {
    try { 
      // força validar com servidor
      await user.getIdToken(true);  // força refresh do token
      await user.reload();          // recarrega dados do servidor
      user = FirebaseAuth.instance.currentUser;
      print('Splash: currentUser (depois reload) = ${user?.uid}');
    } on FirebaseAuthException catch (e) {
      print('Splash: reload/idToken falhou -> ${e.code} | ${e.message}');
      await FirebaseAuth.instance.signOut(); // cache local limpa
      user = null;
    } catch (e) {
      print('Splash: erro genérico no reload -> $e');
      await FirebaseAuth.instance.signOut();
      user = null;
    }
  }

  // --- Passo 2: se ainda não temos usuário, espere um pouco o stream emitir um não-nulo ---
  if (user == null) {
    try {
      user = await FirebaseAuth.instance
          .authStateChanges()
          .firstWhere((u) => u != null)
          .timeout(const Duration(seconds: 2));
      print('Splash: stream trouxe user = ${user?.uid}');
      // valida esse user também
      await user!.getIdToken(true);
      await user.reload();
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      print('Splash: stream/timeout sem user ou falha de validação -> $e');
      user = null;
    }
  }

  if (!mounted) return;

  // --- Decisão final ---
  if (user != null) {
    Navigator.pushReplacementNamed(context, Routes.home);
    return; // logado nunca vê intro
  }

  final prefs = await SharedPreferences.getInstance();
  final showIntro = prefs.getBool('show_intro') ?? true;
  Navigator.pushReplacementNamed(context, showIntro ? Routes.intro : Routes.login);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Lottie.asset(
          'assets/lottie/splash.json',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
