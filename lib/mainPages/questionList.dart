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

  @override
  void initState() {
    // TODO: implement initState
    questionData();
    super.initState();
  }

  questionData() {
    _questionList = widget.question;
    print(widget.question);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _questionList.length,
        itemBuilder: (BuildContext context, int index) {
          final data = _questionList[index];
          final idx = index + 1;
          return ListTile(
            leading: ExcludeSemantics(
              child: CircleAvatar(child: Text('$idx')),
            ),
            title: Text(data),
            // trailing: Icon(Icons.camera_indoor_outlined),
            onTap: () {
              Get.to(QuestionRecode(
                question: data,
              ));
            },
            // TextButton.icon(onPressed: (){}, icon: Icon(Icons.camera_outdoor_outlined), label: '영상녹화'),
          );
        },
      ),
    );
  }
}
