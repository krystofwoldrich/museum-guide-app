import 'package:flutter/material.dart';

class AudioPlayer extends StatelessWidget {
  final String audioName;
  final String audioUrl;

  AudioPlayer({
    @required this.audioUrl,
    this.audioName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {print('pressed');},
            color: Theme.of(context).primaryColor,
            iconSize: 126,
          ),
          Text(
            '3 minutes',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).canvasColor),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 38),
    );
  }
}
