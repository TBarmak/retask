import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/services/to_do_service.dart';
import 'package:retask/shared/constants.dart';

class DecrementTimesRemaining extends StatefulWidget {
  final ToDo toDo;
  final Function setCelebrate;

  DecrementTimesRemaining(this.toDo, this.setCelebrate);

  @override
  _DecrementTimesRemainingState createState() =>
      _DecrementTimesRemainingState();
}

class _DecrementTimesRemainingState extends State<DecrementTimesRemaining> {
  int times = 0;

  @override
  Widget build(BuildContext context) {
    ToDoService toDoService = ToDoService();

    return widget.toDo.completed
        ? Container(
            child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                    "You have already met your goal to " +
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
                    "How many times did you " +
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
                  Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: NumberPicker.integer(
                      textMapper: (val) {
                        return val == "1" ? val + " time" : val + " times";
                      },
                      onChanged: (val) {
                        setState(() {
                          times = val;
                        });
                      },
                      initialValue: times,
                      minValue: 0,
                      maxValue: widget.toDo.timesRemaining,
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
                    ),
                  ),
                  Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                ],
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
                    if (!widget.toDo.completed) {
                      bool result = toDoService.decrementTimesRemaining(
                          widget.toDo, times);
                      widget.setCelebrate(result);
                    }
                    Navigator.pop(context);
                  })
            ],
          ));
  }
}
