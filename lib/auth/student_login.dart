import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileintro/auth/all_exam.dart';
import 'package:mobileintro/const.dart';
import 'package:mobileintro/question.dart';

class student_login extends StatefulWidget {
  const student_login({Key? key}) : super(key: key);

  @override
  _student_loginState createState() => _student_loginState();
}

class _student_loginState extends State<student_login> {
  bool showpass = true;
  var id= TextEditingController();
  var pas= TextEditingController();
  var email= TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(examid[0]),
                    SizedBox(height: 100,),
                    Text(
                      "Student ID:",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: id,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Email:",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: email,

                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Password:",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: pas,
                      obscureText: showpass,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showpass = !showpass;
                                });
                              },
                              icon: Icon(!showpass
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        if (formkey.currentState!.validate()) {

      _login(email.text, pas.text);

                        }
                      },
                      child: Container(
                        child:  Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        height: 50,
                        decoration:
                        BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  _get_exam(){
    examid.forEach((element) {
      FirebaseFirestore.instance.collection("exam").doc(element).collection("question").get().then((value) {
        value.docs.forEach((element2) {
          exam.add(element2.data());
        });
      });
      print(exam);
    });

 }

  _login(email,password){
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
    then((value) {

      Navigator.push(context, MaterialPageRoute(builder: (context) => all_exam(),));

    }).catchError((onError){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(onError.message.toString())));

    });
  }
}
List<Map<String, dynamic>> exam=[];
