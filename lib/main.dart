import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innerview_biz/mainPages/loading.dart';
import 'package:innerview_biz/mainPages/qrScan.dart';
// import 'package:innerview_biz/mainPages/questionList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LodingPage()),
        GetPage(name: '/qrScan', page: () => QRScan()),
        // GetPage(name: '/question', page: () => QuestionList()),
      ],
      //home: LodingPage(),
    );
  }
}
