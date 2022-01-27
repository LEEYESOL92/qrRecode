import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class LodingPage extends StatefulWidget {
  LodingPage({Key? key}) : super(key: key);

  @override
  _LodingPageState createState() => _LodingPageState();
}

class _LodingPageState extends State<LodingPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      // Get.to(QRScan());
      Get.toNamed('/qrScan');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Container(
              child: Center(
            child: Image.asset('images/logo.jpg'),
          )),
          SizedBox(height: 50.0),
        ],
      ),
    ));
  }
}
