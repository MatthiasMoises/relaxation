import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/ambient_player.dart';
import '../widgets/cat_loader.dart';
import '../widgets/background_picker.dart';
import '../widgets/on_your_mind.dart';
import '../widgets/user_thought.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentBackgroundImage = 'assets/images/rain_1.jpg';
  String _currentThought = '';
  bool _audioIsPlaying = false;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentBackgroundImage =
          prefs.getString('backgroundImage') ?? 'assets/images/rain_1.jpg';
      _currentThought = prefs.getString('userThought') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  void _updateMusicStatus() {
    setState(() {
      _audioIsPlaying = !_audioIsPlaying;
    });
  }

  void _updateBackground(background) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('backgroundImage', 'assets/images/$background');
    setState(() {
      _currentBackgroundImage =
          prefs.getString('backgroundImage') ?? 'assets/images/rain_1.jpg';
    });
  }

  void _updateUserThought(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userThought', value);
    setState(() {
      _currentThought = prefs.getString('userThought') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_currentBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Relaxation',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  children: <Widget>[
                    AmbientPlayer(
                      isPlaying: _audioIsPlaying,
                      playStatusHandler: _updateMusicStatus,
                    ),
                    CatLoader(),
                    BackgroundPicker(
                      currentBackgroundImage: _currentBackgroundImage,
                      updateBackgroundImageHandler: _updateBackground,
                    ),
                    OnYourMind(
                      thoughtUpdateHandler: _updateUserThought,
                    ),
                  ],
                ),
                UserThought(
                  currentThought: _currentThought,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
