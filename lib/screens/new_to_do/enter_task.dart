import 'package:flutter/material.dart';
import 'package:retask/constants.dart';

class EnterTask extends StatefulWidget {
  // Functions inherited from the parent widget
  final Function complete;
  final Function setTask;
  final Function setImportance;

  EnterTask(this.complete, this.setTask, this.setImportance);

  @override
  _EnterTaskState createState() => _EnterTaskState();
}

class _EnterTaskState extends State<EnterTask> {
  /// String representing the task being entered (associated with the TextFormField)
  String task = "";

  /// Int representing the importance of the task (associated with the Slider)
  int importance = 0;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
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
                  hintStyle: TextStyle(color: Colors.lightBlue[100]),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)),
                ),
                style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(height: 40),
        Text("Importance:",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
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
        SizedBox(height: 40),
        RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                widget.setImportance(importance);
                widget.setTask(task);
                widget.complete();
              }
            },
            color: Colors.white,
            child: Text('Okay',
                style: TextStyle(color: Colors.blue, fontSize: 20))),
      ],
    );
  }
}
