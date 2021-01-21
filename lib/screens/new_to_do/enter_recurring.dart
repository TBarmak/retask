import 'package:flutter/material.dart';
import 'package:retask/shared/constants.dart';

class EnterRecurring extends StatelessWidget {
  // Functions inherited from the parent widget
  final Function complete;
  final Function setIsRecurring;
  final Function setRecurTimes;

  EnterRecurring(this.complete, this.setIsRecurring, this.setRecurTimes);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(flex: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 100, 0),
          child: Text("Is this task recurring?",
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
              Text("For example, read ",
                  style: TextStyle(
                      color: accentColor1, fontSize: 20, shadows: textShadows)),
              Text("every week.",
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
                    setIsRecurring(true);
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
                    setIsRecurring(false);
                    setRecurTimes(0);
                  },
                  child: Text("No", style: TextStyle(fontSize: 20))))
        ]),
        Spacer(flex: 2),
      ],
    );
  }
}
