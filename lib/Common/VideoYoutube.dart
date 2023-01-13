import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoYoutube extends StatefulWidget {
  VideoYoutube({Key? key}) : super(key: key);

  @override
  State<VideoYoutube> createState() => _VideoYoutubeState();
}

class _VideoYoutubeState extends State<VideoYoutube> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: 'fq4N0hgOWzU',
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
      progressColors: ProgressBarColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
      ),
      onReady: () {
        print('Player is ready.');
      },
    );
  }
}
