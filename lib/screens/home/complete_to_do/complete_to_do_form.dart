import 'package:flutter/material.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/screens/home/complete_to_do/complete_one_time.dart';
import 'package:retask/screens/home/complete_to_do/decrement_duration_remaining.dart';
import 'package:retask/screens/home/complete_to_do/decrement_times_remaining.dart';

class CompleteToDoForm extends StatefulWidget {
  final ToDo toDo;
  final Function setCelebrate;

  CompleteToDoForm(this.toDo, this.setCelebrate);

  @override
  _CompleteToDoFormState createState() => _CompleteToDoFormState();
}

class _CompleteToDoFormState extends State<CompleteToDoForm> {
  @override
  Widget build(BuildContext context) {
    if (widget.toDo.duration != null) {
      return DecrementDurationRemaining(widget.toDo, widget.setCelebrate);
    } else if (widget.toDo.numTimes == 1) {
      return CompleteOneTime(widget.toDo, widget.setCelebrate);
    }
    return DecrementTimesRemaining(widget.toDo, widget.setCelebrate);
  }
}
