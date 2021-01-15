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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Is this task recurring?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 50)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("For example, read ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            Text("every week.",
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
