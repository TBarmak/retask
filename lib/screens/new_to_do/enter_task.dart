import 'package:flutter/material.dart';
import 'package:retask/shared/constants.dart';

class EnterTask extends StatefulWidget {
  // Functions inherited from the parent widget
  final Function complete;
  final Function getTask;
  final Function setTask;
  final Function getImportance;
  final Function setImportance;

  EnterTask(this.complete, this.getTask, this.setTask, this.getImportance,
      this.setImportance);

  @override
  _EnterTaskState createState() => _EnterTaskState();
}

class _EnterTaskState extends State<EnterTask> {
  /// String representing the task being entered (associated with the TextFormField)
  String task;

  /// Int representing the importance of the task (associated with the Slider)
  int importance;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    task = task ?? widget.getTask() ?? "";
    importance = importance ?? widget.getImportance() ?? 0;

    return Column(
      children: [
        Spacer(flex: 3),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
            child: TextFormField(
                maxLength: 60,
                initialValue: task,
                onChanged: (val) {
                  task = val;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a task';
                  } else if (value.length > 60) {
                    return 'Too many characters';
                  }
                  return null;
                },
                decoration: textInputDecoration.copyWith(
                    hintText: "What would you like to do?", counterText: ""),
                style: TextStyle(color: backgroundColor)),
          ),
        ),
        Spacer(flex: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Important?",
                style: TextStyle(color: Colors.white, fontSize: 30)),
            Switch(
              value: importance != 0,
              activeColor: accentColor1,
              activeTrackColor: Color.fromARGB((0.6 * 255).toInt(),
                  accentColor1.red, accentColor1.green, accentColor1.blue),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.white60,
              onChanged: (val) {
                setState(() {
                  val ? importance = 1 : importance = 0;
                });
              },
            )
          ],
        ),
        Spacer(flex: 8),
        RaisedButton(
            elevation: 25,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            color: accentColor1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                widget.setImportance(importance);
                widget.setTask(task);
                widget.complete();
              }
            },
            child: Text('Okay',
                style: TextStyle(color: backgroundColor, fontSize: 20))),
        Spacer(flex: 4),
      ],
    );
  }
}
