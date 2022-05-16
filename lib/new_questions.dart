import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobileintro/main.dart';

class creatr_question extends StatefulWidget {
  const creatr_question({Key? key}) : super(key: key);

  @override
  _creatr_questionState createState() => _creatr_questionState();
}

class _creatr_questionState extends State<creatr_question> {

  set_exam(){
    if(val!=null){
      FirebaseFirestore.instance.collection("exam").doc(q_n.text).collection("question").add({
        "examname":q_n.text,
        "q":q.text,
        "answer":q_a.text,
        "grade":q_g.text,
        "type":val,
        "chose":[ch_1.text,ch_2.text,ch_3.text],
      }).then((value) {
        q.clear();
        q_g.clear();
        q_a.clear();
        ch_1.clear();
        ch_2.clear();
        ch_3.clear();
        val=null;
      });
    }else{
      Fluttertoast.showToast(
          msg: "chose the question type pleases !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }


    FirebaseFirestore.instance.collection("exam").doc(q_n.text).set({
      "exam":"flutterr"
    });
   
  }


  String? val;
  var q = TextEditingController();
  var q_n = TextEditingController();
  var q_a = TextEditingController();
  var q_g = TextEditingController();
  var ch_1 = TextEditingController();
  var ch_2 = TextEditingController();
  var ch_3 = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exam name:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "mustn't be empty";
                    }
                  },
                  controller: q_n,
                  keyboardType: TextInputType.text,

                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Question:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "mustn't be empty";
                    }
                  },
                  controller: q,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                SizedBox(
                  height: 30,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(12),
                  hint: Text("Question Type"),
                  value: val,
                  items: [
                    DropdownMenuItem(
                      child: Text("open"),
                      value: "open",
                    ),
                    DropdownMenuItem(
                      child: Text("close"),
                      value: "close",
                    ),
                    DropdownMenuItem(
                      child: Text("Multiple choices"),
                      value: "Multiple choices",
                    ),
                  ],
                  onChanged: (v) {
                    setState(() {
                      val = v;
                    });
                  },
                ),
                SizedBox(
                  height: 17,
                ),
                if (val == "Multiple choices" || val == "close")
                  Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "mustn't be empty";
                            }
                          },
                          controller: ch_1,
                          decoration: InputDecoration(hintText: "Chose 1"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "mustn't be empty";
                            }
                          },
                          controller: ch_2,
                          decoration: InputDecoration(hintText: "Chose 2"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "mustn't be empty";
                            }
                          },
                          controller: ch_3,
                          decoration: InputDecoration(hintText: "Chose 3"),
                        ),
                      ),
                    )
                  ]),
                SizedBox(
                  height: 55,
                ),
                Text(
                  "Question Grade:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "mustn't be empty";
                    }
                  },
                  controller: q_g,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 33,
                ),
                Text(
                  "Question Ansser:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "mustn't be empty";
                    }
                  },
                  controller: q_a,
                  keyboardType: TextInputType.multiline,
                  minLines: null,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(title: "E-xam"),
                                ),
                                (route) => false);
                          }
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Finish",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          height: 50,
                          margin: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                          set_exam();
                          }
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "NEXT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          margin: EdgeInsets.all(18),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
