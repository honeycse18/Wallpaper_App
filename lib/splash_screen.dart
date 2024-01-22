import 'package:flutter/material.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Home(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/img/logo.png',
          width: 120,
        ),
      ),
    );
  }
}
