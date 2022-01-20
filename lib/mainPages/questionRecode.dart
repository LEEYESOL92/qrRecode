import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

class QuestionRecode extends StatefulWidget {
  final String question;
  QuestionRecode({Key? key, required this.question}) : super(key: key);

  @override
  _QuestionRecodeState createState() => _QuestionRecodeState();
}

class _QuestionRecodeState extends State<QuestionRecode> {
  CameraController? _cameraController;
  Future<void>? _initCameraControllerFuture;
  int cameraIndex = 1;

  bool isCapture = false;
  File? captureImage;

  @override
  void initState() {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    _cameraController =
        new CameraController(cameras[cameraIndex], ResolutionPreset.medium);
    _initCameraControllerFuture = _cameraController!.initialize();
  }

  @override
  void dispose() {
    // _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: _initCameraControllerFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.connectionState);
            print('11111111111111111');
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: <Widget>[
                  Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: CameraPreview(_cameraController!)),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1.0),
                      color: Colors.white,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 3.0),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
