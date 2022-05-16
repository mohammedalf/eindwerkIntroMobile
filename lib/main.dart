import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobileintro/AnswerQuestion.dart';
import 'package:mobileintro/auth/student_login.dart';
import 'package:mobileintro/auth/taecher_login.dart';
import 'package:mobileintro/const.dart';
import 'package:mobileintro/storage.dart';

import 'TeacherHome.dart';

const routeHome = '/';
const routeTeacher = '/teacher';
const routeStudent = '/student';
const routeManageStudents = '/teacher/students';
const routeManageQuestions = '/teacher/questions';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: 'AIzaSyCJE7csuHKuewzVgAHFnDfZ1waaqz0gC_g',
    appId: '1:800562369400:web:fc7b80cb215bf306936e8d',
    messagingSenderId: '800562369400',
    projectId: 'mobile-intro-27',
    authDomain: 'mobile-intro-27.firebaseapp.com',
    storageBucket: 'mobile-intro-27.appspot.com',
    measurementId: 'G-D8T5Z7XYXD',
  )

  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(new MyApp());
  });
}

  class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-xam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      //home: const MyHomePage(title: 'E-xam'),
      onGenerateRoute: (settings) {
        late Widget page;
        switch (settings.name) {
          case routeHome:
            page = const MyHomePage(title: "E-xam");
            break;
          case routeTeacher:
            page = const TeacherHome();
            break;
          case routeStudent:
            page = const StudentHomePage();
            break;
          case routeManageStudents:
            page = const MyHomePage(title: "E-xam");
            break;
          case routeManageQuestions:
            page = const MyHomePage(title: "E-xam");
            break;

          default:
            page = const MyHomePage(title: "E-xam");
            break;
        }
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return page;
          },
          settings: settings,
        );
      },
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _navigateTeacher() {
    get_teacher_data().then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const teacher_login()),
      );
    });

  }

  void _navigateStudent()async {
    await FirebaseFirestore.instance.collection("exam").get().then((value) {
      value.docs.forEach((element) {
        examid.add(element.id);

      });
    });
    
    examid.forEach((element) {
      exam=[];
      FirebaseFirestore.instance.collection("exam").doc(element.toString()).collection("question").get().then((value){
        value.docs.forEach((element) {
          exam.add(element.data());
        });
        print(exam);

      });

    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const student_login()),
    );

  }


 Future get_teacher_data(){
  return  FirebaseFirestore.instance.collection("teacher").doc("1").get().then((value) {
      teacher_data=value.data()!;
      print(teacher_data);
    });
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MyScaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Row(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
              width: 150,
              child: TextButton(
                onPressed:_navigateTeacher,
                child: const Text('Teacher'),
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.red),
              ),
            ),
            SizedBox(
              width: 100,
            ),
            SizedBox(
              height: 150,
              width: 150,
              child: TextButton(
                onPressed: _navigateStudent,
                child: const Text('Student'),
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.red),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      body: Center(
        child: SizedBox(width: 300, child: MyStatefulWidget()),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String? dropdownValue;

  Map<int, String> students = <int, String>{};
  void _navigateAnswerQuestion(int studentnumber) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnswerQuestion(studentnumber: studentnumber)),
    );
  }

  @override
  void initState() {
    Storage().getStudents().then((students) => {
          if (mounted) {
              setState(() {
                this.students = students;
              })
            }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child:
                DropdownButtonFormField<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: students.entries.map((e) => DropdownMenuItem(
                    value: e.key.toString(),
                    child: Text(e.key.toString() + ": " + e.value),
                  )).toList(),
                  validator: (value) {
                    if (value == null || value == "") {
                      return 'Please enter a valid studentnumber';
                    }
                    return null;
                  },
                ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _navigateAnswerQuestion(int.parse(dropdownValue!));
                  }
                },
                child: const Text('Continue'),
            )
          ],
        )
    );
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: students.entries
          .map((e) => DropdownMenuItem(
                value: e.key.toString(),
                child: Text(e.key.toString() + ": " + e.value),
              ))
          .toList(),
    );
  }
}

class _MyAppBarState extends State<MyAppBar> {
  Timer? timer;
  bool isSynced = true;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Storage().isSynced().then((value) => {
        if (mounted) {
          setState(() {
            isSynced = value;
          })
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return AppBar(
      leading: Navigator.canPop(context) ? const BackButton() : null,
      title: const Text('E-xam'),
      actions: [Icon(isSynced ? Icons.cloud_done : Icons.sync_problem)],
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class MyScaffold extends StatelessWidget {
  final Widget body;

  const MyScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: MyAppBar(),
        ),
        body: body);
  }
}
