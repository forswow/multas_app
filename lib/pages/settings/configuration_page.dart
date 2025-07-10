import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreen> {
  final _themeData = GetStorage();
  bool _isdarkMode = false;
  @override
  void initState() {
    super.initState();
    _themeData.writeIfNull("darkmode", false);
    _isdarkMode = _themeData.read("darkmode");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                SwitchListTile(
                  secondary: const Icon(Icons.light_mode),
                  title: const Text(
                    "Modo oscuro",
                  ),
                  value: _isdarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isdarkMode = value;
                    });
                    _isdarkMode
                        ? Get.changeTheme(ThemeData.dark())
                        : Get.changeTheme(ThemeData.light());
                    _themeData.write('darkmode', value);
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
