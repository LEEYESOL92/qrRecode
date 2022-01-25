import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(false);
    // await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      GestureDetector(
        // child: VideoPlayer(_videoPlayerController),
        onTap: () {
          if (!_videoPlayerController.value.isInitialized) {
            return;
          }
          if (_videoPlayerController.value.isPlaying) {
            _videoPlayerController.pause();
          } else {
            _videoPlayerController.play();
          }
        },
        child: Stack(
          children: [
            Container(
              child: VideoPlayer(_videoPlayerController),
            ),
            Center(
                child: Icon(
              _videoPlayerController.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              size: 184.0,
            ))
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: VideoProgressIndicator(
          _videoPlayerController,
          allowScrubbing: true,
        ),
      ),
      Center(
          child: _videoPlayerController.value.isBuffering
              ? const CircularProgressIndicator()
              : null),
    ];

    return Stack(
      fit: StackFit.passthrough,
      children: children,
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       body: FutureBuilder(
//         future: _initVideoPlayer(),
//         builder: (context, state) {
//           if (state.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             // return AspectRatio(
//             //   aspectRatio: _videoPlayerController.value.aspectRatio,
//             //   child: VideoPlayer(_videoPlayerController),
//             // );
//             return GestureDetector(
//               child: VideoPlayer(_videoPlayerController),
//               onTap: () {
//                 if (!_videoPlayerController.value.isInitialized) {
//                   return;
//                 }
//                 //   if (_videoPlayerController.value.isPlaying) {
//                 //     _videoPlayerController.pause();
//                 //   } else {
//                 //     _videoPlayerController.play();
//                 //   }
//               },
//             );
//           }
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     if (_videoPlayerController.value.isPlaying) {
//       //       _videoPlayerController.pause();
//       //     } else {
//       //       _videoPlayerController.play();
//       //     }
//       //   },
//       //   child: Icon(_videoPlayerController.value.isPlaying
//       //       ? Icons.pause
//       //       : Icons.play_arrow),
//       // ),
//     );
//   }
// }

// class _PlayPauseOverlay extends StatelessWidget {
//   const _PlayPauseOverlay({Key? key, required this.controller})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
