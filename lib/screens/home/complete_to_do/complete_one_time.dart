import 'package:flutter/material.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/services/to_do_service.dart';
import 'package:retask/shared/constants.dart';

class CompleteOneTime extends StatelessWidget {
  final ToDo toDo;

  CompleteOneTime(this.toDo);
  @override
  Widget build(BuildContext context) {
    ToDoService toDoService = ToDoService();
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("Did you " + toDo.task.toLowerCase() + "?",
              style: TextStyle(fontSize: 20, color: backgroundColor)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                  elevation: 5,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  color: accentColor1,
                  textColor: backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("Yes", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    if (!toDo.completed) {
                      toDoService.toggleCompleted(toDo);
                    }
                    Navigator.pop(context);
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                  elevation: 5,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  color: accentColor1,
                  textColor: backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("No", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    if (toDo.completed) {
                      toDoService.toggleCompleted(toDo);
                    }
                    Navigator.pop(context);
                  }),
            ),
          ],
        )
      ],
    ));
  }
}
