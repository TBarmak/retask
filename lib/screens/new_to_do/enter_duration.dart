import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:retask/shared/constants.dart';
import 'package:retask/shared/shared.dart';

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
  final Function getRecurWindow;

  EnterDuration(
      this.complete,
      this.getHours,
      this.setHours,
      this.getMinutes,
      this.setMinutes,
      this.getError,
      this.setError,
      this.getTask,
      this.getRecurWindow);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(flex: 2),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 80, 0),
          child: Text(
              "For how long will you " +
                  (getTask().length > 15
                      ? getTask().substring(0, 15) + "..."
                      : getTask()) +
                  (getRecurWindow() == null
                      ? ""
                      : " per " + frequencyToPeriod[getRecurWindow()]) +
                  "?",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: accentColor1, fontSize: 40, shadows: textShadows)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              NumberPicker.integer(
                textMapper: (val) {
                  return val + " hr";
                },
                onChanged: (val) {
                  setHours(val);
                },
                initialValue: getHours() ?? 1,
                minValue: 0,
                maxValue: 100,
                selectedTextStyle: TextStyle(color: Colors.white, fontSize: 25),
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
              NumberPicker.integer(
                textMapper: (val) {
                  return val + " min";
                },
                onChanged: (val) {
                  setMinutes(val);
                },
                initialValue: getMinutes() ?? 0,
                minValue: 0,
                maxValue: 59,
                selectedTextStyle: TextStyle(color: Colors.white, fontSize: 25),
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: screenWidth(context) * 0.4,
            child: Text(getError(),
                textAlign: TextAlign.start,
                style: TextStyle(color: accentColor1, fontSize: 20)),
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
                  if ((getMinutes() ?? 0) + (getHours() ?? 1) == 0) {
                    setError("Duration must be non-zero");
                  } else {
                    setError("");
                    complete();
                  }
                },
                textColor: backgroundColor,
                child: Text('Continue', style: TextStyle(fontSize: 20))),
          ],
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
