import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main(List<String> args) {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "XyloPhone",
      home: XyloHOME(),
    );
  }
}

class XyloHOME extends StatefulWidget {
  @override
  _XyloHOMEState createState() => _XyloHOMEState();
}

class _XyloHOMEState extends State<XyloHOME> {
  int _count = 0;
  void playSound(int? soundNumber) async {
    _count = _count + 1;
    print('playSound Count : $_count\n');
    AudioCache player = AudioCache(
      duckAudio: true,
    );
    await player.play(
      'Note_$soundNumber.wav',
      mode: PlayerMode.LOW_LATENCY,
      volume: 1.0,
    );
    if (_count >= 7) {
      player.clearCache();
      _count = 0;
    }
  }

  Widget buildNoteWidget({Color? btnColor, int? soundNumber}) {
    return Expanded(
      child: MaterialButton(
        onPressed: () {
          HapticFeedback.vibrate();
          playSound(soundNumber);
        },
        onLongPress: () {
          HapticFeedback.vibrate();
          playSound(soundNumber);
        },
        splashColor: btnColor,
        highlightColor: btnColor,
        color: btnColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildNoteWidget(btnColor: Colors.indigo, soundNumber: 1),
                buildNoteWidget(btnColor: Colors.blue, soundNumber: 2),
                buildNoteWidget(btnColor: Colors.green, soundNumber: 3),
                buildNoteWidget(btnColor: Colors.yellow, soundNumber: 4),
                buildNoteWidget(btnColor: Colors.orange, soundNumber: 5),
                buildNoteWidget(btnColor: Colors.red, soundNumber: 6),
                buildNoteWidget(btnColor: Colors.teal, soundNumber: 7),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
