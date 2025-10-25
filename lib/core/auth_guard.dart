import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerador_de_senha/screens/HomeScreen.dart';
import 'package:gerador_de_senha/screens/LoginERegistro.dart';
import 'package:gerador_de_senha/screens/SplashScreen.dart';
/*
class AuthGuard extends StatelessWidget {
  final Widget child;
  const AuthGuard({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // não logado → redireciona para Login
        return const SplashScreen();
      },
    );
  }
}
*/