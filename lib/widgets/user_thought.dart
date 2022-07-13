import 'package:flutter/material.dart';

class UserThought extends StatelessWidget {
  final String currentThought;

  UserThought({required this.currentThought});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        currentThought,
        style: TextStyle(fontFamily: 'DancingScript', fontSize: 32.0, shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Colors.black,
            offset: Offset(5.0, 5.0),
          ),
        ]),
      ),
    );
  }
}
