import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnYourMind extends StatefulWidget {
  final Function thoughtUpdateHandler;

  OnYourMind({required this.thoughtUpdateHandler});

  @override
  _OnYourMindState createState() => _OnYourMindState();
}

class _OnYourMindState extends State<OnYourMind> {
  final TextEditingController _textFieldController = TextEditingController();
  String _currentThought = '';

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentThought = prefs.getString('userThought') ?? '';
      _textFieldController.text = _currentThought;
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('What\'s on your mind?'),
            content: TextField(
              maxLength: 30,
              autofocus: true,
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Tell me everything..."),
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  widget.thoughtUpdateHandler(_textFieldController.text);
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.create_rounded,
        size: 80.0,
        color: Colors.white,
      ),
      onTap: () => displayTextInputDialog(context),
    );
  }
}
