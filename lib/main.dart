import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: YesNoPage(),
    );
}
}

class YesNoPage extends StatefulWidget {
  @override
  _YesNoPageState createState() => _YesNoPageState();
}

class _YesNoPageState extends State<YesNoPage> {
  TextEditingController _controller = TextEditingController();
  String _responseText = "";
  String _imageUrl = "";

  void _fetchYesNoResponse(String question) async {
    final response = await http.get(Uri.parse('https://yesno.wtf/api'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _responseText = data['answer'];
        _imageUrl = data['image'];
        _controller.clear();
      });
    } else {
      setState(() {
        _responseText = "Falla al obtener respuesta";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yes/No API')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.endsWith('?')) {
                      _fetchYesNoResponse(_controller.text);
                    }
                  },
                ),
                hintText: 'Ingresa tu pregunta:',
              ),
            ),
            SizedBox(height: 20),
            _imageUrl.isNotEmpty
                ? Image.network(_imageUrl)
                : Container(),
            SizedBox(height: 20),
            Text(
              _responseText,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}