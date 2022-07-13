import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relaxation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Nunito',
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
