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
        Text("Is the task time-based?",
            style: TextStyle(color: Colors.white, fontSize: 20)),
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
