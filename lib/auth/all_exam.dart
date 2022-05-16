import 'package:flutter/material.dart';
import 'package:mobileintro/auth/student_login.dart';
import 'package:mobileintro/const.dart';
import 'package:mobileintro/question.dart';

class all_exam extends StatefulWidget {
  const all_exam({Key? key}) : super(key: key);

  @override
  _all_examState createState() => _all_examState();
}

class _all_examState extends State<all_exam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView.builder(
          itemCount: examid.length,
          itemBuilder: (context, index) => ListTile(
            leading:Text("${index+1}") ,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => qustions(),));
            },
            title: Text(examid[index]),
          ),
        ),
      ),
    );
  }
}
