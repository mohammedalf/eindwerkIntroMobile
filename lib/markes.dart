
import 'package:flutter/material.dart';
import 'package:mobileintro/show.dart';

class markes extends StatefulWidget {
  const markes({Key? key}) : super(key: key);

  @override
  _markesState createState() => _markesState();
}

class _markesState extends State<markes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
             Expanded(
               child: ListView.builder(
                 itemCount: 1,
                 itemBuilder: (context, index) => ListTile(title: Text("Omer",style: TextStyle(fontSize: 22),),onTap:(){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => show(),));

               },),),
             )
        ]),
      ),
    );
  }
}
