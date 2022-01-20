import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:innerview_biz/mainPages/questionList.dart';

class CompanyInfo extends StatelessWidget {
  final dynamic company;
  const CompanyInfo({Key? key, required this.company}) : super(key: key);

  // String name = company['name'];
  @override
  Widget build(BuildContext context) {
    print(this.company['applywork']);
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            '회사명',
            style: TextStyle(letterSpacing: 2.0, color: Colors.teal[600]),
          ),
          Text(
            // company,
            this.company['name'],
            style: TextStyle(
                color: Colors.teal[900],
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            '지원분야',
            style: TextStyle(letterSpacing: 2.0, color: Colors.teal[600]),
          ),
          Text(
            //company,
            this.company['applyInfo'],
            style: TextStyle(
                color: Colors.teal[900],
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            '담당업무',
            style: TextStyle(letterSpacing: 2.0, color: Colors.teal[600]),
          ),
          Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < this.company['applywork'].length; i++)
                    Text(this.company['applywork'][i])
                ],
              ),
            ),
            // children: <Widget>[
            //   for (int i = 0; i < this.company['applywork'].length; i++)
            //     Text('123123' + this.company['applywork'][i])
            // ],
          )
        ],
      ),
    );
  }
}
