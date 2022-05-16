import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class qustions extends StatefulWidget {
  const qustions({Key? key}) : super(key: key);

  @override
  _qustionsState createState() => _qustionsState();
}

class _qustionsState extends State<qustions> {
  var c = PageController();

  List text = [
    {
      "q":
      "What is favourite subject What is favourite subject What is favourite subject What is favourite subject ",
      "ch": [
        "math1",
        "arb1",
        "english1",
      ],
      "anser": "math",
      "t": "multe",
    },
    {
      "q": "What is favourite subject ",
      "ch": [
        "math2",
        "arb2",
        "english2",
      ],
      "anser": "math",
      "t": "one",
    },
    {
      "q": "What is favourite subject ",
      "anser": "he is good for this",
      "t": "open",
    },
  ];

  List<bool> g = [
    false,
    false,
    false,
  ];
  List<bool> b = [
    false,
    false,
    false,
  ];

  List y = [
    "math",
    "arb",
    "english",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Text("Finish"),
          onPressed: () {
            setState(() {
              c.animateToPage(2,
                  duration: Duration(seconds: 1), curve: Curves.linear);
            });
          }),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: c,
              itemCount: text.length,
              itemBuilder: (context, index) {
                return _iteam(text[index], index);
              },
            ),
          )
        ]),
      ),
    );
  }

  Widget _open(model, index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q${index + 1} / ${text.length}",
          style: TextStyle(
              color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "${model["q"]}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 18,
        ),
        TextFormField(
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }

  Widget _multe(model, index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q${index + 1} / ${text.length}",
          style: TextStyle(
              color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "${model["q"]}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 18,
        ),
        Column(
          children: [
            ListTile(
              title: Text(model["ch"][0]),
              leading: Checkbox(
                  value: g[0],
                  onChanged: (v) {
                    setState(() {
                      g[0] = !g[0];
                    });
                  }),
            ),
            ListTile(
              title: Text(model["ch"][1]),
              leading: Checkbox(
                  value: g[1],
                  onChanged: (v) {
                    setState(() {
                      g[1] = !g[1];
                    });
                  }),
            ),
            ListTile(
              title: Text(model["ch"][2]),
              leading: Checkbox(
                  value: g[2],
                  onChanged: (v) {
                    setState(() {
                      g[2] = !g[2];
                    });
                  }),
            ),
          ],
        )
      ],
    );
  }

  Widget _one(model, index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q${index + 1} / ${text.length}",
          style: TextStyle(
              color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          model["q"],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 18,
        ),
        Column(
          children: [
            ListTile(
              title: Text(model["ch"][0]),
              leading: Checkbox(
                  value: g[0],
                  onChanged: (v) {
                    setState(() {
                      g[0] = !g[0];
                    });
                  }),
            ),
            ListTile(
              title: Text(model["ch"][1]),
              leading: Checkbox(
                  value: g[1],
                  onChanged: (v) {
                    setState(() {
                      g[1] = !g[1];
                    });
                  }),
            ),
            ListTile(
              title: Text(model["ch"][2]),
              leading: Checkbox(
                  value: g[2],
                  onChanged: (v) {
                    setState(() {
                      g[2] = !g[2];
                    });
                  }),
            ),
          ],
        )
      ],
    );
  }

  Widget _iteam(model, index) {
    if (model["t"] == "multe") {
      return _multe(model, index);
    } else if (model["t"] == "open") {
      return _open(model, index);
    } else {
      return _one(model, index);
    }
  }
}
