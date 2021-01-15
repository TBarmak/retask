import 'package:flutter/material.dart';

class EnterTimeBased extends StatelessWidget {
  // Functions inherited from the parent widget
  final Function complete;
  final Function setTimeBased;

  EnterTimeBased(this.complete, this.setTimeBased);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Is the task time-based?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 50)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("For example, read for ",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20)),
            Text("30 minutes.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.underline)),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: EdgeInsets.all(5),
              child: RaisedButton(
                  color: Colors.white,
                  textColor: Colors.blue,
                  onPressed: () {
                    complete();
                    setTimeBased(true);
                  },
                  child: Text("Yes"))),
          Container(
              margin: EdgeInsets.all(5),
              child: RaisedButton(
                  color: Colors.white,
                  textColor: Colors.blue,
                  onPressed: () {
                    complete();
                    setTimeBased(false);
                  },
                  child: Text("No")))
        ])
      ],
    );
  }
}
