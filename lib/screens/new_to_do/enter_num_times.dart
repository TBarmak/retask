import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

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
    /// Converts time periods from adverb form to noun
    Map frequencyToPeriod = {
      'daily': 'day',
      'weekly': 'week',
      'monthly': 'month',
      'annually': 'year'
    };

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Include the recur window in the message, if there is one
              Text(
                  "How many times" +
                      (getRecurWindow() == null
                          ? " "
                          : " per " +
                              frequencyToPeriod[getRecurWindow()] +
                              " ") +
                      "will you " +
                      getTask() +
                      "?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("For example, read ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text("5",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.underline)),
                  Text(" books.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ],
          ),
        ),
        NumberPicker.integer(
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
        RaisedButton(
            onPressed: () {
              complete();
            },
            color: Colors.white,
            child: Text('Add To-Do',
                style: TextStyle(color: Colors.blue, fontSize: 20))),
      ],
    );
  }
}
