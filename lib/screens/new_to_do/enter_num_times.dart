import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:retask/shared/constants.dart';
import 'package:retask/shared/shared.dart';

class EnterNumTimes extends StatelessWidget {
  // Functions inherited from the parent widget
  final Function complete;
  final Function getRecurWindow;
  final Function getNumTimes;
  final Function setNumTimes;
  final Function getTask;

  EnterNumTimes(this.complete, this.getRecurWindow, this.getNumTimes,
      this.setNumTimes, this.getTask);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(flex: 2),
        // Include the recur window in the message, if there is one
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: screenWidth(context) * 0.8,
            child: Text(
                "How many times" +
                    (getRecurWindow() == null
                        ? " "
                        : " per " + frequencyToPeriod[getRecurWindow()] + " ") +
                    "will you " +
                    (getTask().length > 15
                        ? getTask().substring(0, 15) + "..."
                        : getTask()) +
                    "?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: accentColor1, fontSize: 35, shadows: textShadows)),
          ),
        ),
        Spacer(flex: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("For example, read ",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: accentColor1, fontSize: 20, shadows: textShadows)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text("5",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: accentColor1,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      shadows: textShadows)),
              Text(" books.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: accentColor1, fontSize: 20, shadows: textShadows)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: NumberPicker.integer(
            onChanged: (val) {
              setNumTimes(val);
            },
            initialValue: getNumTimes() ?? 1,
            minValue: 1,
            maxValue: 500,
            selectedTextStyle: TextStyle(color: Colors.white, fontSize: 30),
            textStyle: TextStyle(color: Colors.white, fontSize: 15),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.white,
                ),
                bottom: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Spacer(flex: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                elevation: 25,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                color: accentColor1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  complete();
                },
                textColor: backgroundColor,
                child: Text('Add To-Do', style: TextStyle(fontSize: 20))),
          ],
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
