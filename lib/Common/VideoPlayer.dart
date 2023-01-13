// ignore_for_file: unnecessary_import, file_names, implementation_imports, prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key}) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController controller;
  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(
        'https://www.fluttercampus.com/video.mp4');
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
        title: Center(
          child:  Text(
            "How Our Advisory Works?",
            style: TextStyle(
              fontFamily: 'Productsans',
              color:Get.isDarkMode? Colors.white: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        Text("Total Duration: " + controller.value.duration.toString()),
        Container(
            child: VideoProgressIndicator(controller,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  backgroundColor: Colors.redAccent,
                  playedColor: Colors.red,
                  bufferedColor: Colors.grey,
                ))),
        Container(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (controller.value.isPlaying) {
                      controller.pause();
                    } else {
                      controller.play();
                    }

                    setState(() {});
                  },
                  icon: Icon(controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow)),
              IconButton(
                  onPressed: () {
                    controller.seekTo(Duration(seconds: 0));

                    setState(() {});
                  },
                  icon: Icon(Icons.stop))
            ],
          ),
        )
      ]),
    );
  }
}
