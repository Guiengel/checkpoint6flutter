import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Sair",
            onPressed: _signOut,
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Bem-vindo, ${user?.email ?? 'Usuário'}",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
