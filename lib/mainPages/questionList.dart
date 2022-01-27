import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:innerview_biz/mainPages/questionRecode.dart';
import 'package:get/get.dart';

class QuestionList extends StatefulWidget {
  QuestionList({Key? key, required this.question}) : super(key: key);
  final List question;

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List<dynamic> _questionList = [];
  int? selectIdx;

  @override
  void initState() {
    // TODO: implement initState
    questionData();
    super.initState();
  }

  questionData() {
    _questionList = widget.question;
    // print(widget.question);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: _questionList.length,
          itemBuilder: (BuildContext context, int index) {
            final data = _questionList[index];
            final idx = index + 1;
            return Card(
              color: idx == selectIdx ? Colors.green[900] : Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 240, 118, 62),
                  child: Text('$idx'),
                ),
                title: Text(data!['question']),
                onTap: () {
                  setState(() {
                    selectIdx = idx;
                  });
                },
              ),
            );
          }),
    );
    /* return Container(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        scrollDirection: Axis.vertical,
        itemCount: _questionList.length,
        itemBuilder: (BuildContext context, int index) {
          final data = _questionList[index];
          final idx = index + 1;
          return Container(
            height: 100.0,
            color: Color.fromARGB(255, 173, 209, 175),
            child: Row(
              children: <Widget>[
                Icon(data!['iscommit'] == '1'
                    ? Icons.check_circle_outline_outlined
                    : Icons.circle_outlined),
                Container(
                  width: 50.0,
                  child: Text('$idx'),
                ),
                Text(data!['question']),
              ],
            ),
          );
        },
      ),
    );*/
  }
}
