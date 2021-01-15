import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class EnterDuration extends StatelessWidget {
  // Functions inherited from the parent widget
  final Function complete;
  final Function getHours;
  final Function setHours;
  final Function getMinutes;
  final Function setMinutes;
  final Function getError;
  final Function setError;
  final Function getTask;

  EnterDuration(this.complete, this.getHours, this.setHours, this.getMinutes,
      this.setMinutes, this.getError, this.setError, this.getTask);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("How long will you " + getTask() + "?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 50)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 50),
            NumberPicker.integer(
              onChanged: (val) {
                setHours(val);
              },
              initialValue: getHours() ?? 1,
              minValue: 0,
              maxValue: 100,
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
            SizedBox(width: 20),
            Text("Hours", style: TextStyle(color: Colors.white, fontSize: 40))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 50),
            NumberPicker.integer(
              onChanged: (val) {
                setMinutes(val);
              },
              initialValue: getMinutes() ?? 0,
              minValue: 0,
              maxValue: 59,
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
            SizedBox(width: 20),
            Text("Minutes", style: TextStyle(color: Colors.white, fontSize: 40))
          ],
        ),
        SizedBox(height: 20),
        Text(getError(), style: TextStyle(color: Colors.red, fontSize: 20)),
        SizedBox(height: 20),
        RaisedButton(
            onPressed: () {
              if ((getMinutes() ?? 0) + (getHours() ?? 1) == 0) {
                setError("Duration must be non-zero");
              } else {
                setError("");
                complete();
              }
            },
            color: Colors.white,
            child: Text('Continue',
                style: TextStyle(color: Colors.blue, fontSize: 20))),
      ],
    );
  }
}
