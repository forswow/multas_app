import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/navigation_bar.dart';
import 'package:get_storage/get_storage.dart';

final _themedata = GetStorage();
void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool _darkMode = _themedata.read('darkmode') ?? false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Multas',
      theme: _darkMode
          ? ThemeData.dark(
              useMaterial3: false,
            )
          : ThemeData.light(
              useMaterial3: false,
            ),
      home: const Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavigationBarExample()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
