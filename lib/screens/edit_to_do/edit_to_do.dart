import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:retask/shared/constants.dart';
import 'package:retask/models/to_do.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

  int recurTimes;
  String recurWindow;

  /// Used to indicate if the user changed the dueDate in the form
  bool dueDateChanged = false;
  DateTime dueDate;

  int importance;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    data = ModalRoute.of(context).settings.arguments;
    toDo = data['toDo'];

    task = task ?? toDo.task;

    duration = toDo.duration;
    if (duration != null) {
      hours = hours ?? duration.inHours;
      minutes = minutes ?? duration.inMinutes - (60 * hours);
    }

    numTimes = numTimes ?? toDo.numTimes;

    recurTimes = recurTimes ?? toDo.recurTimes;
    recurWindow = recurWindow ?? toDo.recurWindow;

    // null check doesn't work because dueDate is allowed to be null
    dueDateChanged ? dueDate = dueDate : dueDate = toDo.dueDate;

    importance = importance ?? toDo.importance;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, elevation: 0),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
            elevation: 0,
            color: Colors.white,
            child: Text("Update", style: TextStyle(color: Colors.blue)),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                toDo.task = task;
                // If the task is duration-based
                if (duration != null) {
                  duration = Duration(minutes: hours * 60 + minutes);
                  // If the new duration is shorter than the original, reduce durationRemaining accordingly.
                  if (duration.compareTo(toDo.duration) < 0) {
                    toDo.durationRemaining =
                        toDo.durationRemaining - (toDo.duration - duration);
                    toDo.durationRemaining =
                        toDo.durationRemaining < Duration(minutes: 0)
                            ? Duration(minutes: 0)
                            : toDo.durationRemaining;
                    // If the new duration is longer (or equal to) the original, increase durationRemaining accordingly.
                  } else {
                    toDo.durationRemaining =
                        toDo.durationRemaining + (duration - toDo.duration);
                  }
                  toDo.completed =
                      toDo.durationRemaining == Duration(minutes: 0);
                  toDo.duration = duration;
                }
                // If the task is not duration-based
                else {
                  // If the new number of times is less than the original, reduce timesRemaining accordingly.
                  if (numTimes < toDo.numTimes) {
                    toDo.timesRemaining =
                        toDo.timesRemaining - (toDo.numTimes - numTimes);
                    // If the new number of times is greater (or equal to) the original, increase timesRemaining accordingly.
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

                // If the task is not recurring, set recurWindow and recurTimes to the appropriate values
                if (recurWindow != "none" && recurTimes != 0) {
                  toDo.recurWindow = recurWindow;
                  toDo.recurTimes = recurTimes;
                } else {
                  toDo.recurWindow = null;
                  toDo.recurTimes = 0;
                }

                toDo.dueDate = dueDate;

                toDo.importance = importance;

                Navigator.pop(context, {"toDo": toDo});
              }
            }),
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                      Flexible(
                          flex: 6,
                          fit: FlexFit.tight,
                          child: Container(
                            alignment: Alignment(-1, 0),
                            child: Text("Task",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          )),
                      Flexible(
                        flex: 8,
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      Flexible(flex: 1, fit: FlexFit.tight, child: Container())
                    ],
                  ),
                ],
              ),
            ),
            duration != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment(0.8, 0),
                          child: NumberPicker.integer(
                            textMapper: (val) {
                              return val == "1" ? val + " hr" : val + " hrs";
                            },
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
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
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
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-0.8, 0),
                          child: NumberPicker.integer(
                            textMapper: (val) {
                              return val + " min";
                            },
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
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
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
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: NumberPicker.integer(
                          textMapper: (val) {
                            return val == "1" ? val + " time" : val + " times";
                          },
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
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
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
                      Flexible(flex: 1, fit: FlexFit.tight, child: Container())
                    ],
                  ),
            Row(
              children: [
                Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                Flexible(
                  flex: 6,
                  fit: FlexFit.tight,
                  child: Container(
                    alignment: Alignment(-1, 0),
                    child: Text("Recurring",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    dropdownColor: Colors.blue,
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    onChanged: (val) {
                      setState(() {
                        recurWindow = val;
                        if (recurWindow != "none") {
                          // Recuring tasks must have due dates
                          dueDateChanged = true;
                          dueDate = dueDate ?? DateTime.now();
                          // Set the default recur times to be indefinite
                          recurTimes = -1;
                        }
                      });
                    },
                    value: recurWindow ?? recurWindowOptions[0],
                    items: recurWindowOptions.map((String option) {
                      return DropdownMenuItem(
                          value: option, child: Row(children: [Text(option)]));
                    }).toList(),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(),
                )
              ],
            ),
            (recurWindow ?? "none") == "none"
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(flex: 1, child: Container()),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: NumberPicker.integer(
                          // 0 will represent "indefinitely" on the NumberPicker
                          // It will be converted to -1 when creating the ToDo
                          // 0 recurTimes is not recurring, -1 is indefinitely recurring
                          textMapper: (val) {
                            return val == "0"
                                ? "Indefinitely"
                                : (val == "1" ? val + " time" : val + " times");
                          },
                          onChanged: (val) {
                            setState(() {
                              val == 0 ? recurTimes = -1 : recurTimes = val;
                            });
                          },
                          // If recurTimes == -1, make the initialValue 0
                          initialValue: recurTimes < 0 ? 0 : recurTimes,
                          minValue: 0,
                          maxValue: 500,
                          selectedTextStyle:
                              TextStyle(color: Colors.white, fontSize: 30),
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
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
                      Flexible(flex: 1, child: Container()),
                    ],
                  ),
            Row(
              children: [
                Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                Flexible(
                  flex: 6,
                  fit: FlexFit.tight,
                  child: Container(
                    alignment: Alignment(-1, 0),
                    child: Text(
                        ((recurWindow ?? "none") == "none" ? "" : "First ") +
                            "Due Date",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: RaisedButton(
                      child: Text(
                          dueDate != null
                              ? "${DateFormat('MMMM dd, yyyy').format(dueDate)}"
                              : "None",
                          style: TextStyle(color: Colors.blue)),
                      onPressed: () async {
                        _openPopup(context, (newDueDate) {
                          setState(() {
                            dueDateChanged = true;
                            dueDate = newDueDate;
                          });
                        }, (recurWindow ?? "none") != "none");
                      },
                      color: Colors.white),
                ),
                Flexible(flex: 1, fit: FlexFit.tight, child: Container())
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(),
                ),
                Flexible(
                  flex: 6,
                  fit: FlexFit.tight,
                  child: Container(
                    alignment: Alignment(-1, 0),
                    child: Text("Importance",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: Slider(
                      activeColor: importanceColors[importance],
                      inactiveColor: Colors.white,
                      value: importance.toDouble(),
                      min: 0,
                      max: 2,
                      divisions: 2,
                      onChanged: (val) {
                        setState(() {
                          importance = val.toInt();
                        });
                      }),
                ),
                Flexible(flex: 1, fit: FlexFit.tight, child: Container())
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Opens an Alert to set the dueDate
/// setDueDate sets the dueDate
/// recurring (bool) - indicates if the task is recurring, recurring tasks must have due dates
_openPopup(context, setDueDate, recurring) {
  DateTime dueDate;

  List<DialogButton> buttons = [
    DialogButton(
      onPressed: () {
        dueDate = null;
        setDueDate(dueDate);
        Navigator.pop(context);
      },
      child: Text(
        "No due date",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
    DialogButton(
      onPressed: () {
        dueDate = dueDate ?? DateTime.now();
        setDueDate(dueDate);
        Navigator.pop(context);
      },
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  ];

  if (recurring) {
    buttons.removeAt(0);
  }

  Alert(
          context: context,
          title: "Due Date",
          content: Container(
            width: 300,
            height: 400,
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                      onDateChanged: (val) {
                        dueDate = val;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          buttons: buttons)
      .show();
}
