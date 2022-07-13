import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AmbientPlayer extends StatefulWidget {
  final bool isPlaying;
  final Function playStatusHandler;

  AmbientPlayer({
    required this.isPlaying,
    required this.playStatusHandler,
  });

  @override
  _AmbientPlayerState createState() => _AmbientPlayerState();
}

class _AmbientPlayerState extends State<AmbientPlayer> {
  late AudioPlayer _player;
  late AudioCache _audioCache;
  final List<Map> _audioFiles = [
    {'id': 1, 'name': 'Forest', 'file': 'forest.mp3'},
    {'id': 2, 'name': 'Ocean', 'file': 'ocean.mp3'},
    {'id': 3, 'name': 'Rain', 'file': 'rain.mp3'},
    {'id': 4, 'name': 'Sunset', 'file': 'sunset.mp3'},
    {'id': 5, 'name': 'Cat Purring', 'file': 'cat_purring.mp3'},
  ];

  @override
  initState() {
    super.initState();
    _player = new AudioPlayer();
    _player.setVolume(100.0);
    _audioCache = new AudioCache(fixedPlayer: _player);
  }

  @override
  dispose() {
    super.dispose();
    _player.stop();
  }

  void _playLocal(sound) async {
    await _audioCache.play('audio/$sound');
  }

  void _stopAudioPlayer() async {
    await _player.stop();
    widget.playStatusHandler();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.55,
                minChildSize: 0.2,
                maxChildSize: 0.75,
                builder: (_, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: controller,
                            itemCount: _audioFiles.length,
                            itemBuilder: (_, index) {
                              return Card(
                                color: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: InkWell(
                                  splashColor: Colors.blue,
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      _audioFiles[index]['name'],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _playLocal(_audioFiles[index]['file']);
                                    widget.playStatusHandler();
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        widget.isPlaying ? Icons.stop : Icons.play_arrow,
        size: 80.0,
        color: Colors.white,
      ),
      onTap: () =>
          widget.isPlaying ? _stopAudioPlayer() : _showBottomSheet(context),
    );
  }
}
