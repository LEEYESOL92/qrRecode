import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class QuestionRecode extends StatefulWidget {
  final String question;
  QuestionRecode({Key? key, required this.question}) : super(key: key);

  @override
  _QuestionRecodeState createState() => _QuestionRecodeState();
}

class _QuestionRecodeState extends State<QuestionRecode> {
  PickedFile? _image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecorder();
  }

  getRecorder() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: Center(
        child:
            _image == null ? Text('no image') : Image.file(File(_image!.path)),
      ),
    ));
  }
}
