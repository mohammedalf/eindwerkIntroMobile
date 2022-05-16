import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileintro/csvReader.dart';
import 'package:mobileintro/storage.dart';

import 'main.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  var students = <int, String>{};
  bool loading = true;

  @override
  void initState() {
    Storage().getStudents().then((students) => {
          setState(() {
            this.students = students;
          }),
          setLoading(false)
        });
    super.initState();
  }

  bool showpass = true;
  var id = TextEditingController();
  var pas = TextEditingController();
  var email = TextEditingController();
  var name = TextEditingController();

  _set_data(name,email,id) {
    FirebaseFirestore.instance.collection("mystudents").add({
      "name":name,
      "email":email,
      "id":id,
    });
  }

  _craet_user(
    email,
    password,
      id,
      name
  ) {

    _set_data(name, email, id);
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return MyScaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              const CircularProgressIndicator(
                value: null,
                semanticsLabel: 'Linear progress indicator',
              ),
            if (!loading)
              Wrap(
                spacing: 8.0, // gap between adjacent chips
                runSpacing: 4.0, // gap between lines
                children: [
                  for (int key in students.keys)
                    InputChip(
                      avatar: const Icon(Icons.remove),
                      label: Text(students[key]!),
                      onPressed: () {
                        setLoading(true);
                        Storage().removeStudent(key);
                        Storage().getStudents().then((students) => {
                              setState(() {
                                this.students = students;
                              }),
                              setLoading(false)
                            });
                      },
                    )
                ],
              ),
            const SizedBox(
              height: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          "Student ID:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                          controller: id,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          "Student name:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                          controller: name,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          "Email:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        _craet_user(email.text, pas.text, id.text, name.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Student is added"),
                        ));
                      }
                    },
                    child: const Text('Add student'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setLoading(true);
                      CsvReader().getStudents().then((students) => {
                            Storage().addStudents(students),
                            Storage().getStudents().then((students) => {
                                  setState(() {
                                    this.students = students;
                                  }),
                                  setLoading(false)
                                })
                          });
                    },
                    child: const Text('Import students'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  setLoading(bool loading) {
    if (mounted) {
      setState(() {
        this.loading = loading;
      });
    }
  }
}
