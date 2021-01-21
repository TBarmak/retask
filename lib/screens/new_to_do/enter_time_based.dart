import 'package:flutter/material.dart';
import 'package:retask/shared/constants.dart';

class EnterTimeBased extends StatelessWidget {
  // Functions inherited from the parent widget
  final Function complete;
  final Function setTimeBased;

  EnterTimeBased(this.complete, this.setTimeBased);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(flex: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 100, 0),
          child: Text("Is the task time-based?",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: accentColor1, fontSize: 50, shadows: textShadows)),
        ),
        Spacer(flex: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("For example, read for ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: accentColor1, fontSize: 20, shadows: textShadows)),
              Text("30 minutes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: accentColor1,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      shadows: textShadows)),
            ],
          ),
        ),
        Spacer(flex: 4),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: EdgeInsets.all(5),
              child: RaisedButton(
                  elevation: 25,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  color: accentColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textColor: backgroundColor,
                  onPressed: () {
                    complete();
                    setTimeBased(true);
                  },
                  child: Text("Yes", style: TextStyle(fontSize: 20)))),
          Container(
              margin: EdgeInsets.all(5),
              child: RaisedButton(
                  elevation: 25,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  color: accentColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textColor: backgroundColor,
                  onPressed: () {
                    complete();
                    setTimeBased(false);
                  },
                  child: Text("No", style: TextStyle(fontSize: 20))))
        ]),
        Spacer(flex: 2),
      ],
    );
  }
}
