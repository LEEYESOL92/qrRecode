import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:innerview_biz/mainPages/questionList.dart';
import 'package:innerview_biz/mainPages/questionRecode.dart';

class QRScanInfo extends StatefulWidget {
  QRScanInfo({Key? key, required this.qrData}) : super(key: key);
  final dynamic qrData;

  @override
  _QRScanInfoState createState() => _QRScanInfoState();
}

class _QRScanInfoState extends State<QRScanInfo> {
  String _companyName = "";
  String _applyInfo = "";
  List<dynamic> _question = [];
  int? selectIdx;
  dynamic selectData = "";

  @override
  void initState() {
    super.initState();
    print(widget.qrData);
    qrDataJson();
  }

  qrDataJson() async {
    // Map<String, dynamic> qrScanData = jsonDecode(widget.qrData);
    Map<String, dynamic> qrScanData =
        Map<String, dynamic>.from(json.decode(widget.qrData));
    _companyName = qrScanData['company']['name'];
    _applyInfo = qrScanData['company']['applyInfo'];
    _question = qrScanData['questionList'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(13.0),
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Image.asset('images/logo.jpg'),
                  Text(_companyName + ' / ' + _applyInfo,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0)),
                  const Text('녹화면접',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0))
                ],
              )),
          Expanded(
            flex: 6,
            child: Container(
              child: ListView.builder(
                  itemCount: _question.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = _question[index];
                    final idx = index + 1;
                    return Card(
                      color:
                          idx == selectIdx ? Colors.green[900] : Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 240, 118, 62),
                          child: Text(
                            '$idx',
                            style: TextStyle(
                                color: Colors.yellow[500],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          data!['question'],
                          style: TextStyle(
                              color: idx == selectIdx
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            selectIdx = idx;
                            selectData = data;
                          });
                        },
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            height: 50,
            child: RaisedButton(
              child: const Text('촬영하기',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0)),
              color: Colors.red[800],
              onPressed: () {
                Get.to(QuestionRecode(
                  question: selectData,
                ));
              },
              // onPressed: () {Get.to(QuestionRecode())},
            ),
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
