import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/services/to_do_service.dart';

class DecrementDurationRemaining extends StatefulWidget {
  final ToDo toDo;

  DecrementDurationRemaining(this.toDo);

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
                        widget.toDo.task +
                        ".",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40)),
              ),
              RaisedButton(
                  child: Text("Okay"),
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
                        widget.toDo.task.toLowerCase() +
                        "?",
                    style: TextStyle(fontSize: 20)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberPicker.integer(
                    onChanged: (val) {
                      setState(() {
                        if (val == widget.toDo.durationRemaining.inHours) {
                          minutes = maxMinutes;
                        }
                        hours = val;
                      });
                    },
                    initialValue: hours,
                    minValue: 0,
                    maxValue: widget.toDo.durationRemaining.inHours,
                    selectedTextStyle:
                        TextStyle(color: Colors.black, fontSize: 30),
                    textStyle: TextStyle(color: Colors.black, fontSize: 15),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        ),
                        bottom: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text("hr", style: TextStyle(fontSize: 30)),
                  SizedBox(width: 20),
                  NumberPicker.integer(
                    onChanged: (val) {
                      setState(() {
                        minutes = val;
                      });
                    },
                    initialValue: minutes,
                    minValue: 0,
                    // Make sure that the user cannot select a duration that is longer than the durationRemaining.
                    maxValue: hours == widget.toDo.durationRemaining.inHours
                        ? maxMinutes
                        : 59,
                    selectedTextStyle:
                        TextStyle(color: Colors.black, fontSize: 30),
                    textStyle: TextStyle(color: Colors.black, fontSize: 15),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        ),
                        bottom: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text("min", style: TextStyle(fontSize: 30))
                ],
              ),
              RaisedButton(
                  child: Text('Okay'),
                  onPressed: () {
                    toDoService.decrementDurationRemaining(
                        widget.toDo, Duration(hours: hours, minutes: minutes));
                    Navigator.pop(context);
                  })
            ],
          ));
  }
}
