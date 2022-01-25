import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RecodePlayer extends StatefulWidget {
  final String filePath;
  RecodePlayer({Key? key, required this.filePath}) : super(key: key);

  @override
  _RecodePlayerState createState() => _RecodePlayerState();
}

class _RecodePlayerState extends State<RecodePlayer> {
  late VideoPlayerController _videoPlayerController;
  String VideoUrl = "";
  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  Future _initVideoPlayer() async {
    print("1?????????????????????");
    print(widget.filePath);

    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize().then((_) => setState(() {}));
    await _videoPlayerController.setLooping(false);
    VideoUrl = widget.filePath;
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: FutureBuilder(builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: Stack(
                  children: <Widget>[
                    VideoPlayer(_videoPlayerController),
                    _ControlsOverlay(controller: _videoPlayerController),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: VideoProgressIndicator(_videoPlayerController,
                          allowScrubbing: true),
                    ),
                    uploadButton(
                      controller: _videoPlayerController,
                    )
                    // Align(
                    //     alignment: Alignment.topRight,
                    //     child: Icon(Icons.upload, size: 50)),
                  ],
                ));
          }
        }));
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}

class uploadButton extends StatelessWidget {
  const uploadButton({Key? key, required this.controller}) : super(key: key);
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton.icon(
              onPressed: () {
                Get.defaultDialog(
                  title: "",
                  content: Text('업로드 되었습니다.\n제출 전까지 수정 가능합니다.'),
                  barrierDismissible: false,
                  radius: 20.0,
                  actions: <Widget>[
                    FlatButton(onPressed: () {}, child: Text('앱종료하기')),
                    FlatButton(onPressed: () {}, child: Text('다른 문항 촬영하기')),
                  ],
                );
              },
              icon: Icon(Icons.upload, size: 50),
              label: Text('업로드')),
        )
      ],
    );
  }
}
