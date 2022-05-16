import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mobileintro/TeacherHome.dart';
import 'package:mobileintro/const.dart';

class teacher_login extends StatefulWidget {
  const teacher_login({Key? key}) : super(key: key);

  @override
  _teacher_loginState createState() => _teacher_loginState();
}

class _teacher_loginState extends State<teacher_login> {
  bool showpass = true;
  var pas = TextEditingController();
  var email = TextEditingController();
  var formkey = GlobalKey<FormState>();

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
                    Text(
                      "Email:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "mustn't be empty";
                        }
                      },
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Password:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "mustn't be empty";
                        }
                      },
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
                          if (pas.text == teacher_data["pass"] &&
                              email.text == teacher_data["email"]) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TeacherHome()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("The password or e-mail may be wrong"),
                            ));
                          }
                        }
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        height: 50,
                        decoration: BoxDecoration(
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
}
