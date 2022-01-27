import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/painting.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:innerview_biz/mainPages/recodePlayer.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:io/ansi.dart';

class QuestionRecode extends StatefulWidget {
  QuestionRecode({Key? key, required this.question}) : super(key: key);
  final question;

  @override
  _QuestionRecodeState createState() => _QuestionRecodeState();
}

class _QuestionRecodeState extends State<QuestionRecode> {
  bool _isLoading = true;
  bool _isRecording = false;
  late Timer _timer;
  int _timeCount = 0;

/***************/
  String questionSet = "";
  int? timeout;
/***************/
  late CameraController _cameraController;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _initCamera();
    questionDataSetting();
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

  questionDataSetting() {
    questionSet = widget.question['question'];
    timeout = widget.question['timeout'] * 3600;
  }

  _recordVideo(status) async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      _pause();

      GallerySaver.saveVideo(file.path)
          .then((value) => print('갤러리저장완료!'))
          .catchError((err) {
        print('저장에러!');
      });

      if (status == 'timeover') {
        _showDialog(file.path);
      } else {
        Get.off(RecodePlayer(filePath: file.path));
      }
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();

      setState(() => _isRecording = true);
      _start();
    }
  }

  _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (_timeCount == timeout) {
        _recordVideo('timeover');
      }
      setState(() {
        _timeCount++;
      });
    });
  }

  _pause() {
    _timer.cancel();
    _timeCount = 0;
  }

  showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(questionSet),
      backgroundColor: Colors.teal,
      action: SnackBarAction(
        label: 'X',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _showDialog(filePath) {
    Get.defaultDialog(
      title: "",
      content: const Text('-분이 넘었습니다.\n 촬영을 종료합니다.'),
      barrierDismissible: false,
      radius: 20.0,
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              // Get.off(VideoPage(filePath: filePath));
              Get.offAll(RecodePlayer(filePath: filePath));
            },
            child: const Text('영상확인하기')),
        FlatButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('다시 촬영하기')),
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
              CameraGuide(),
              Container(child: timerView()),
              Container(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(_isRecording ? Icons.stop : Icons.circle),
                  onPressed: () => _recordVideo('stop'),
                  // onPressed: () => {},
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  onPressed: () => {showSnackBar(context)},
                  icon: const Icon(Icons.info_outline),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget timerView() {
    String minutes = (_timeCount ~/ 3600).toString().padLeft(2, '0');
    String seconds = ((_timeCount % 3600) ~/ 60).toString().padLeft(2, '0');
    String secs = (_timeCount % 60).toString().padLeft(2, '0');

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('$minutes' ':' '$seconds' ':' '$secs',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
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

  Widget CameraGuide() {
    return Center(
      child: _isRecording
          ? const SizedBox.shrink()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.mood_rounded,
                  size: 184.0,
                ),
                Text('영역에 맞춰 촬영해주세요')
              ],
            ),
    );
  }
}
