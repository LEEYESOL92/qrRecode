import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:innerview_biz/mainPages/companyInfo.dart';
import 'package:innerview_biz/mainPages/questionList.dart';

class QRScanInfo extends StatefulWidget {
  QRScanInfo({Key? key, required this.qrData}) : super(key: key);
  final String qrData;

  @override
  _QRScanInfoState createState() => _QRScanInfoState();
}

class _QRScanInfoState extends State<QRScanInfo> {
  dynamic _company = "";
  String _companyName = "";
  List<dynamic> _question = [];
  @override
  void initState() {
    // TODO: implement initState
    qrDataJson();
    super.initState();
  }

  qrDataJson() async {
    print(widget.qrData);
    Map<String, dynamic> qrScanData = jsonDecode(widget.qrData);
    // print(qrScanData['company']['name']);
    _company = qrScanData['company'];
    _companyName = qrScanData['company']['name'];
    // _companyUrl = qrScanData['companyurl'];
    _question = qrScanData['question'];
    // print(qrScanData['question'][0]);
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    // appBar: AppBar(
    //   title: Text(_company, style: TextStyle(color: Colors.grey[600])),
    //   // title: Text("testtest", style: TextStyle(color: Colors.grey[600])),
    //   backgroundColor: Colors.white,
    //   centerTitle: true,
    //   bottom: TabBar(
    //     tabs: <Widget>[
    //       Tab(
    //           child: Column(children: <Widget>[
    //         Icon(Icons.directions_car),
    //         Text("car")
    //       ])),
    //       Tab(icon: Icon(Icons.directions_transit), text: "transit"),
    //       Tab(icon: Icon(Icons.directions_bike), text: "bike")
    //     ],
    //   ),
    // ),
    return DefaultTabController(
      // 탭의 수 설정
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // TabBar
          title: Text(_companyName, style: TextStyle(color: Colors.grey[200])),
          backgroundColor: Colors.grey[800],
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "기업정보", icon: Icon(Icons.work)),
              Tab(text: "자소서", icon: Icon(Icons.record_voice_over_outlined)),
            ],
          ),
        ),

        // TabVarView
        body: TabBarView(
          children: <Widget>[
            CompanyInfo(company: _company),
            QuestionList(question: _question),
            // Text(
            //   '회사명',
            //   style: TextStyle(
            //       color: Colors.lightBlueAccent[900], letterSpacing: 5.0),
            // ),
            // Center(
            //   child: Text(
            //     "2",
            //     style: TextStyle(fontSize: 40, color: Colors.grey),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // );

}
