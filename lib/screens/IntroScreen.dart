import 'package:flutter/material.dart';
import 'package:gerador_de_senha/routes.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _dontShowAgain = false;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Bem-vindo ao App',
      'subtitle': 'Aprenda a usar o app passo a passo.',
      'lottie': 'assets/lottie/intro1.json',
    },
    {
      'title': 'Funcionalidades',
      'subtitle': 'Gere suas senhas!',
      'lottie': 'assets/lottie/intro2.json',
    },
    {
      'title': 'Comece Agora',
      'subtitle': 'Vamos começar a usar o app!',
      'lottie': 'assets/lottie/intro3.json',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Aqui será adicionado o conteudo da intro
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Expanded(child: Lottie.asset(page['lottie']!)),
                        Text(
                          page['title']!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          page['subtitle']!,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Aqui será adicionado o checkbox
            if (isLastPage)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _dontShowAgain,
                      onChanged: (val) {
                        setState(() {
                          _dontShowAgain = val ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text('Não mostrar essa introdução novamente.'),
                    ),
                  ],
                ),
              ),
            // Aqui serão adicionados os botões de navegação
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    TextButton(onPressed: _onBack, child: Text("Voltar"))
                  else
                    SizedBox(width: 80),
                  TextButton(
                    onPressed: _onNext,
                    child: Text(isLastPage ? 'Concluir' : 'Avançar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _finishIntro() {
    Navigator.pushReplacementNamed(context, Routes.home);
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _finishIntro();
    }
  }

  void _onBack() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}