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
  String _applyInfo = "";
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
    _applyInfo = qrScanData['company']['applyInfo'];
    // _companyUrl = qrScanData['companyurl'];
    _question = qrScanData['question'];
    // print(qrScanData['question'][0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text('캐치이미지들어갈듯,.', style: TextStyle(color: Colors.black)),
        //     // title: Text("testtest", style: TextStyle(color: Colors.grey[600])),
        //     backgroundColor: Colors.white,
        //     centerTitle: true),
        body: Padding(
      padding: EdgeInsets.all(50.0),
      child: Column(
        children: <Widget>[
          Flexible(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Image.asset('images/logo.jpg'),
                  Text(_companyName + ' / ' + _applyInfo,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0)),
                  Text('녹화면접',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0))
                ],
              )
              // child: Container(
              //   child: Image.asset('images/logo.jpg'),
              // ),
              ),
          Flexible(
            flex: 5,
            child: QuestionList(question: _question),
          )
        ],
      ),
    ));
  }
}
//탭바사용할때
    // return DefaultTabController(
    //   // 탭의 수 설정
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       // TabBar
    //       title: Text(_companyName, style: TextStyle(color: Colors.grey[200])),
    //       backgroundColor: Colors.grey[800],
    //       centerTitle: true,
    //       bottom: TabBar(
    //         tabs: [
    //           Tab(text: "기업정보", icon: Icon(Icons.work)),
    //           Tab(text: "자소서", icon: Icon(Icons.record_voice_over_outlined)),
    //         ],
    //       ),
    //     ),

    //     // TabVarView
    //     body: TabBarView(
    //       children: <Widget>[
    //         CompanyInfo(company: _company),
    //         QuestionList(question: _question),
    //       ],
    //     ),
    //   ),
    // );
