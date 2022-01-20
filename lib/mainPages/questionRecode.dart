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
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    print(widget.question);
    final cameras = await availableCameras();

    _cameraController =
        CameraController(cameras[cameraIndex], ResolutionPreset.medium);
    _initCameraControllerFuture = _cameraController!.initialize();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
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
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: CameraPreview(_cameraController!),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),

//  Center(child: CircularProgressIndicator());

      // Column(
      // children: <Widget>[

      // Flexible(
      //   flex: 3,
      //   fit: FlexFit.tight,
      //   child: FutureBuilder<void>(
      //     future: _initCameraControllerFuture,
      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         return SizedBox(
      //           width: size.width,
      //           height: size.width,
      //           child: ClipRect(
      //             child: FittedBox(
      //               fit: BoxFit.fitWidth,
      //               child: SizedBox(
      //                 width: size.width,
      //                 child: AspectRatio(
      //                     aspectRatio:
      //                         1 / _cameraController!.value.aspectRatio,
      //                     child: CameraPreview(_cameraController!)),
      //               ),
      //             ),
      //           ),
      //         );
      //       } else {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //     },
      //   ),
      // ),
      // Flexible(
      //   flex: 1,
      //   child: Container(
      //     alignment: Alignment.centerRight,
      //     padding: const EdgeInsets.symmetric(horizontal: 48.0),
      //     child: Stack(
      //       //alignment: Alignment.center,
      //       children: [
      //         GestureDetector(
      //           onTap: () async {
      //             try {
      //               await _cameraController!.takePicture().then((value) {
      //                 captureImage = File(value.path);
      //               });

      //               /// 화면 상태 변경 및 이미지 저장
      //               setState(() {
      //                 isCapture = true;
      //               });
      //             } catch (e) {
      //               print("$e");
      //             }
      //           },
      //           child: Container(
      //             height: 50.0,
      //             width: 50.0,
      //             padding: const EdgeInsets.all(1.0),
      //             decoration: BoxDecoration(
      //               shape: BoxShape.circle,
      //               border: Border.all(color: Colors.black, width: 1.0),
      //               color: Colors.white,
      //             ),
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 shape: BoxShape.circle,
      //                 border: Border.all(color: Colors.black, width: 3.0),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // ],
      // )
    );
  }
}
