import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/services/to_do_service.dart';
import 'package:retask/shared/constants.dart';

class DecrementDurationRemaining extends StatefulWidget {
  final ToDo toDo;
  final Function setCelebrate;

  DecrementDurationRemaining(this.toDo, this.setCelebrate);

  @override
  _DecrementDurationRemainingState createState() =>
      _DecrementDurationRemainingState();
}

class _DecrementDurationRemainingState
    extends State<DecrementDurationRemaining> {
  int hours = 0;
  int minutes = 0;

  @override
  Widget build(BuildContext context) {
    /// The remaining minutes above the whole number of hours
    int maxMinutes = widget.toDo.durationRemaining.inMinutes -
        widget.toDo.durationRemaining.inHours * 60;

    ToDoService toDoService = ToDoService();

    /* 
    If the task has been completed, tell the user that they have completed the
    task. Otherwise, allow them to select the duration that they have done the task.
    */
    return widget.toDo.completed
        ? Container(
            child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                    "You have already met your duration goal to " +
                        (widget.toDo.task.length > 15
                                ? widget.toDo.task.substring(0, 15) + "..."
                                : widget.toDo.task)
                            .toLowerCase() +
                        ".",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: backgroundColor, fontSize: 20)),
              ),
              RaisedButton(
                  textColor: backgroundColor,
                  elevation: 5,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  color: accentColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("Okay", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ))
        : Container(
            child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                    "How much time did you " +
                        (widget.toDo.task.length > 15
                                ? widget.toDo.task.substring(0, 15) + "..."
                                : widget.toDo.task)
                            .toLowerCase() +
                        "?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: backgroundColor, fontSize: 20)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 2),
                  widget.toDo.durationRemaining.inHours > 0
                      ? NumberPicker.integer(
                          listViewWidth: 150,
                          textMapper: (val) {
                            return val + " hr";
                          },
                          onChanged: (val) {
                            setState(() {
                              if (val ==
                                      widget.toDo.durationRemaining.inHours &&
                                  minutes > maxMinutes) {
                                minutes = maxMinutes;
                              }
                              hours = val;
                            });
                          },
                          initialValue: hours,
                          minValue: 0,
                          maxValue: widget.toDo.durationRemaining.inHours,
                          selectedTextStyle:
                              TextStyle(color: backgroundColor, fontSize: 30),
                          textStyle:
                              TextStyle(color: backgroundColor, fontSize: 15),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                style: BorderStyle.solid,
                                color: backgroundColor,
                              ),
                              bottom: BorderSide(
                                style: BorderStyle.solid,
                                color: backgroundColor,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  widget.toDo.durationRemaining.inHours > 0
                      ? Spacer(flex: 1)
                      : Container(),
                  NumberPicker.integer(
                    listViewWidth: 150,
                    onChanged: (val) {
                      setState(() {
                        minutes = val;
                      });
                    },
                    textMapper: (val) {
                      return val + " min";
                    },
                    initialValue: minutes,
                    minValue: 0,
                    // Make sure that the user cannot select a duration that is longer than the durationRemaining.
                    maxValue: hours == widget.toDo.durationRemaining.inHours
                        ? maxMinutes
                        : 59,
                    selectedTextStyle:
                        TextStyle(color: backgroundColor, fontSize: 30),
                    textStyle: TextStyle(color: backgroundColor, fontSize: 15),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          style: BorderStyle.solid,
                          color: backgroundColor,
                        ),
                        bottom: BorderSide(
                          style: BorderStyle.solid,
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
              RaisedButton(
                  textColor: backgroundColor,
                  elevation: 5,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  color: accentColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('Okay', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    bool result = toDoService.decrementDurationRemaining(
                        widget.toDo, Duration(hours: hours, minutes: minutes));
                    widget.setCelebrate(result);
                    Navigator.pop(context);
                  })
            ],
          ));
  }
}
