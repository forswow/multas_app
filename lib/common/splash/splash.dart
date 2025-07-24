import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () => context.pushReplacement('/'),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
            ],
          ),
        ),
      );
}
