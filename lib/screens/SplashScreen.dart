import 'package:flutter/material.dart';
import 'package:gerador_de_senha/routes.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
  super.initState();
  Future.delayed(const Duration(milliseconds: 1400), () {
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(Routes.intro);
  });
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
