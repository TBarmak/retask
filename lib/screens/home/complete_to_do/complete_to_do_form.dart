import 'package:flutter/material.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/screens/home/complete_to_do/complete_one_time.dart';

class CompleteToDoForm extends StatefulWidget {
  final ToDo toDo;

  CompleteToDoForm(this.toDo);

  @override
  _CompleteToDoFormState createState() => _CompleteToDoFormState();
}

class _CompleteToDoFormState extends State<CompleteToDoForm> {
  @override
  Widget build(BuildContext context) {
    if (widget.toDo.duration != null) {
      return Container();
    } else if (widget.toDo.numTimes == 1) {
      return CompleteOneTime(widget.toDo);
    }
    return Container();
  }
}