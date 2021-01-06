import 'package:flutter/material.dart';
import 'package:retask/models/to_do.dart';

class CompleteToDoForm extends StatefulWidget {
  final ToDo toDo;

  CompleteToDoForm(this.toDo);

  @override
  _CompleteToDoFormState createState() => _CompleteToDoFormState();
}

class _CompleteToDoFormState extends State<CompleteToDoForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("Did you " + widget.toDo.task.toLowerCase() + "?",
              style: TextStyle(fontSize: 20)),
        ),
        RaisedButton(
            child: Text("Okay"),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    ));
  }
}
