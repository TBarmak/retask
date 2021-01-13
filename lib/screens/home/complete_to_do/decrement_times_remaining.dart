import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/services/to_do_service.dart';

class DecrementTimesRemaining extends StatefulWidget {
  final ToDo toDo;

  DecrementTimesRemaining(this.toDo);

  @override
  _DecrementTimesRemainingState createState() =>
      _DecrementTimesRemainingState();
}

class _DecrementTimesRemainingState extends State<DecrementTimesRemaining> {
  int times = 0;

  @override
  Widget build(BuildContext context) {
    ToDoService toDoService = ToDoService();

    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
              "How many times did you " + widget.toDo.task.toLowerCase() + "?",
              style: TextStyle(fontSize: 20)),
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
                selectedTextStyle: TextStyle(color: Colors.black, fontSize: 30),
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
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
          ],
        ),
        RaisedButton(
            color: Colors.blue,
            child: Text("Okay", style: TextStyle(color: Colors.white)),
            onPressed: () {
              if (!widget.toDo.completed) {
                toDoService.decrementTimesRemaining(widget.toDo, times);
              }
              Navigator.pop(context);
            })
      ],
    ));
  }
}
