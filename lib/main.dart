import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Examen',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Examen - Edwin Acosta'),
        ),
        body: Center(
          child: Container(
            child: Text('Haz una pregunta'),
          ),
        ),
      ),
    );
  }
}