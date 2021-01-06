import 'package:flutter/material.dart';

class EnterRecurring extends StatelessWidget {
  // Functions inherited from the parent widget
  final Function complete;
  final Function setIsRecurring;
  final Function setRecurTimes;

  EnterRecurring(this.complete, this.setIsRecurring, this.setRecurTimes);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Is this task recurring?",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: EdgeInsets.all(5),
              child: RaisedButton(
                  color: Colors.white,
                  textColor: Colors.blue,
                  onPressed: () {
                    complete();
                    setIsRecurring(true);
                  },
                  child: Text("Yes"))),
          Container(
              margin: EdgeInsets.all(5),
              child: RaisedButton(
                  color: Colors.white,
                  textColor: Colors.blue,
                  onPressed: () {
                    complete();
                    setIsRecurring(false);
                    setRecurTimes(0);
                  },
                  child: Text("No")))
        ])
      ],
    );
  }
}
