import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart' as Player;
class AudioPlayer extends StatefulWidget {
  final String audioName;
  final String audioUrl;

  AudioPlayer({
    @required this.audioUrl,
    this.audioName,
  });

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  Player.AudioPlayerState playerState;
  Player.AudioPlayer player;

  _AudioPlayerState() 
    : this.player = new Player.AudioPlayer()
    , this.playerState = Player.AudioPlayerState.STOPPED 
  {
    this._playerInit();
  }

  @override
  Widget build(BuildContext context) {
    Icon playerMainActionIcon = Icon(Icons.play_arrow);
    if (this.playerState == Player.AudioPlayerState.PLAYING) {
      playerMainActionIcon = Icon(Icons.pause);
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          IconButton(
            icon: playerMainActionIcon,
            onPressed: this._playerController,
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

  @override
  void dispose() {
    super.dispose();

    this._playerDispose();
  }

  Future<void> _playerController() async {
    switch (this.playerState) {
      case Player.AudioPlayerState.STOPPED:
      case Player.AudioPlayerState.COMPLETED:
        await this.player.play(this.widget.audioUrl);
        this.setState(() => playerState = Player.AudioPlayerState.PLAYING);
        break;
      
      case Player.AudioPlayerState.PLAYING:
        await this.player.pause();
        this.setState(() => playerState = Player.AudioPlayerState.PAUSED);
        break;

      case Player.AudioPlayerState.PAUSED:
        await this.player.resume();
        this.setState(() => playerState = Player.AudioPlayerState.PLAYING);
        break;

      default:
        print('Audio Player is in unknown state.');
    }
  }

  void _playerInit() {
    this.player.onPlayerCompletion.listen((event) {
      if (this.mounted) {
        this.setState(() => playerState = Player.AudioPlayerState.PLAYING);
      }
    });

    this.player.onPlayerStateChanged.listen((Player.AudioPlayerState state) {
      if (this.mounted) {
        this.setState(() => playerState = state);
      }
    });
  }

  void _playerDispose() {
    this.player.stop();
    this.player.release();
  }
}
