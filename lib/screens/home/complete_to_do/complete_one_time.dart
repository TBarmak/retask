import 'package:flutter/material.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/services/to_do_service.dart';

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
              style: TextStyle(fontSize: 20)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                  child: Text("Yes"),
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
                  child: Text("No"),
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
