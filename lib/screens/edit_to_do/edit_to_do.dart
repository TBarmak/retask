import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:retask/models/to_do.dart';

class EditToDo extends StatefulWidget {
  @override
  _EditToDoState createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo> {
  Map data = {};
  ToDo toDo;

  String task;

  Duration duration;
  int hours;
  int minutes;

  int numTimes;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    data = ModalRoute.of(context).settings.arguments;
    toDo = data == null ? ToDo("") : data['toDo'];

    task = toDo.task;

    duration = toDo.duration;
    if (duration != null) {
      hours = hours ?? duration.inHours;
      minutes = minutes ?? duration.inMinutes - 60 * hours;
    }

    numTimes = numTimes ?? toDo.numTimes;

    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue, elevation: 0),
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            alignment: Alignment(0, 0),
                            child: Text("Task:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          )),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: TextFormField(
                            initialValue: task,
                            onChanged: (val) {
                              task = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a task';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Task",
                              hintStyle:
                                  TextStyle(color: Colors.lightBlue[100]),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                            ),
                            style: TextStyle(color: Colors.white)),
                      ),
                      Flexible(flex: 1, child: Container())
                    ],
                  ),
                ],
              ),
            ),
            duration != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberPicker.integer(
                        onChanged: (val) {
                          setState(() {
                            hours = val;
                          });
                        },
                        initialValue: hours,
                        minValue: 0,
                        maxValue: 100,
                        selectedTextStyle:
                            TextStyle(color: Colors.white, fontSize: 30),
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
                      Text("hrs",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      NumberPicker.integer(
                        onChanged: (val) {
                          setState(() {
                            minutes = val;
                          });
                        },
                        initialValue: minutes,
                        minValue: 0,
                        maxValue: 100,
                        selectedTextStyle:
                            TextStyle(color: Colors.white, fontSize: 30),
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
                      Text("min",
                          style: TextStyle(color: Colors.white, fontSize: 20))
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberPicker.integer(
                        onChanged: (val) {
                          setState(() {
                            numTimes = val;
                          });
                        },
                        initialValue: numTimes,
                        minValue: 1,
                        maxValue: 500,
                        selectedTextStyle:
                            TextStyle(color: Colors.white, fontSize: 30),
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
                      Text("times",
                          style: TextStyle(color: Colors.white, fontSize: 20))
                    ],
                  ),
            RaisedButton(
                color: Colors.white,
                child: Text("Update", style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    toDo.task = task;
                    if (duration != null) {
                      duration = Duration(minutes: hours * 60 + minutes);
                      /* If the new duration is shorter than the original, reduce durationRemaining accordingly. */
                      if (duration.compareTo(toDo.duration) < 0) {
                        toDo.durationRemaining =
                            toDo.durationRemaining - (toDo.duration - duration);
                        toDo.durationRemaining =
                            toDo.durationRemaining < Duration(minutes: 0)
                                ? Duration(minutes: 0)
                                : toDo.durationRemaining;
                        /* If the new duration is longer (or equal to) the original, increase durationRemaining accordingly. */
                      } else {
                        toDo.durationRemaining =
                            toDo.durationRemaining + (duration - toDo.duration);
                      }
                      toDo.completed =
                          toDo.durationRemaining == Duration(minutes: 0);
                      toDo.duration = duration;
                    } else {
                      /* If the new number of times is less than the original, reduce timesRemaining accordingly. */
                      if (numTimes < toDo.numTimes) {
                        toDo.timesRemaining =
                            toDo.timesRemaining - (toDo.numTimes - numTimes);
                        /* If the new number of times is greater (or equal to) the original, increase timesRemaining accordingly. */
                      } else {
                        toDo.timesRemaining =
                            toDo.timesRemaining + (numTimes - toDo.numTimes);
                      }
                      // Make sure this works for one-off tasks because I don't think it does
                      toDo.timesRemaining =
                          toDo.timesRemaining < 0 ? 0 : toDo.timesRemaining;
                      toDo.completed = toDo.timesRemaining == 0;
                      toDo.numTimes = numTimes;
                    }
                    Navigator.pop(context, {"toDo": toDo});
                  }
                })
          ],
        ));
  }
}
