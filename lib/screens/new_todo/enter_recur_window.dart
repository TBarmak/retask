import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class EnterRecurWindow extends StatelessWidget {
  // Functions inherited from the parent widget
  final Function complete;
  final Function getRecurWindow;
  final Function setRecurWindow;
  final Function getRecurTimes;
  final Function setRecurTimes;
  final Function getError;
  final Function setError;

  EnterRecurWindow(this.complete, this.getRecurWindow, this.setRecurWindow,
      this.getRecurTimes, this.setRecurTimes, this.getError, this.setError);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    /// Options for the period over which the task recurs
    List<String> options = ['daily', 'weekly', 'monthly', 'annually'];

    return Column(
      children: [
        Text("Recurring window:",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null) {
                  return 'Please select a recur window';
                }
                return null;
              },
              dropdownColor: Colors.blue,
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.white,
              style: TextStyle(color: Colors.white, fontSize: 20),
              onChanged: (value) {
                setRecurWindow(value);
              },
              value: getRecurWindow(),
              hint:
                  Text("Select period", style: TextStyle(color: Colors.white)),
              items: options.map((String option) {
                return DropdownMenuItem(
                    value: option, child: Row(children: [Text(option)]));
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 30),
        Text('Number of times:',
            style: TextStyle(color: Colors.white, fontSize: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: getRecurTimes() == -1
                    ? Icon(Icons.check_box, color: Colors.white)
                    : Icon(Icons.check_box_outline_blank, color: Colors.white),
                onPressed: () {
                  setRecurTimes(getRecurTimes() == -1 ? null : -1);
                }),
            Text('Indefinitely',
                style: TextStyle(color: Colors.white, fontSize: 20))
          ],
        ),
        getRecurTimes() != -1
            ? NumberPicker.integer(
                onChanged: (val) {
                  setRecurTimes(val);
                },
                initialValue: getRecurTimes() ?? 1,
                minValue: 1,
                maxValue: 500,
                selectedTextStyle: TextStyle(color: Colors.white, fontSize: 30),
                textStyle: TextStyle(color: Colors.white, fontSize: 15),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.white,
                    ),
                    bottom: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Container(),
        SizedBox(height: 30),
        Text(getError(), style: TextStyle(color: Colors.red, fontSize: 20)),
        RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                setRecurTimes(getRecurTimes() ?? 1);
                complete();
              }
            },
            color: Colors.white,
            child: Text('Continue',
                style: TextStyle(color: Colors.blue, fontSize: 20)))
      ],
    );
  }
}
