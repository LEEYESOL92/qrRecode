// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:innerview_biz/mainPages/videoPage.dart';
import 'package:innerview_biz/mainPages/recodePlayer.dart';
import 'package:path_provider/path_provider.dart';

class QuestionRecode extends StatefulWidget {
  final String question;
  QuestionRecode({Key? key, required this.question}) : super(key: key);

  @override
  _QuestionRecodeState createState() => _QuestionRecodeState();
}

class _QuestionRecodeState extends State<QuestionRecode> {
  bool _isLoading = true;
  bool _isRecording = false;

  bool _isRunning = false;

  late Timer _timer;
  int _timeCount = 0;
  late CameraController _cameraController;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _timer.cancel();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo(status) async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);

      if (status == 'timeover') {
        _showDialog(file.path);
      } else {
        Get.off(VideoPage(filePath: file.path));
      }

      _isRunning = !_isRunning;
      _pause();
      // Navigator.push(context, route);
    } else {
      _isRunning = !_isRunning;

      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      _start();
      setState(() => _isRecording = true);
    }
  }

  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (_timeCount == 300) {
        _recordVideo('timeover');
      }
      setState(() {
        _timeCount++;
      });
    });
  }

  void _pause() {
    // _cameraController.takePicture(filePath);
    _timer.cancel();
    _timeCount = 0;
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(widget.question),
      backgroundColor: Colors.teal,
      action: SnackBarAction(
        label: 'X',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showDialog(filePath) {
    Get.defaultDialog(
      title: "",
      content: Text('-분이 넘었습니다.\n 촬영을 종료합니다.'),
      barrierDismissible: false,
      radius: 20.0,
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              // Get.off(VideoPage(filePath: filePath));
              Get.off(RecodePlayer(filePath: filePath));
            },
            child: Text('영상확인하기')),
        FlatButton(
            onPressed: () {
              Get.back();
            },
            child: Text('다시 촬영하기')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              CameraPreview(_cameraController),
              Container(
                child: cameraGuide(),
              ),
              Container(child: timerView()),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Icon(_isRecording ? Icons.stop : Icons.circle),
                    onPressed: () => _recordVideo('stop'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    onPressed: () => {showSnackBar(context)},
                    icon: Icon(Icons.info_outline),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget timerView() {
    // String secs = milliseconds ~/ 1000;
    String minutes = (_timeCount ~/ 3600).toString().padLeft(2, '0');
    String seconds = ((_timeCount % 3600) ~/ 60).toString().padLeft(2, '0');
    String secs = (_timeCount % 60).toString().padLeft(2, '0');

    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('$minutes' + ':' + '$seconds' + ':' + '$secs',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            backgroundColor: Colors.red)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cameraGuide() {
    return Center(
      child: Container(
        height: 200.0,
        width: 200.0,
        child: Column(
          children: <Widget>[
            Icon(
              Icons.mood_rounded,
              size: 184.0,
            ),
            Text('영역에 맞춰 촬영해주세요')
          ],
        ),
      ),
    );
  }
}
