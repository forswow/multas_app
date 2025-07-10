import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFromFileScreen extends StatefulWidget {
  const TextFromFileScreen({super.key});

  @override
  _TextFromFileScreenState createState() => _TextFromFileScreenState();
}

class _TextFromFileScreenState extends State<TextFromFileScreen> {
  String _fileContents = '';

  @override
  void initState() {
    super.initState();
    _loadText();
  }

  Future<void> _loadText() async {
    try {
      String contents = await rootBundle.loadString('assets/text/privacy.txt');
      setState(() {
        _fileContents = contents;
      });
    } catch (e) {
      print("Error loading file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          _fileContents,
          style: TextStyle(fontSize: 14.0),
        ),
      ),
    );
  }
}
