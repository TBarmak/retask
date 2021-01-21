import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:retask/shared/constants.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(flex: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Recurring window:",
              style: TextStyle(
                  color: accentColor1, fontSize: 30, shadows: textShadows)),
        ),
        Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 90, 0),
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null) {
                  return 'Please select a recur window';
                }
                return null;
              },
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  errorStyle: TextStyle(color: accentColor1),
                  focusedErrorBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: accentColor1, width: 2.0)),
                  errorBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: accentColor1, width: 2.0))),
              dropdownColor: accentColor1,
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
        Spacer(flex: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Number of times:',
              style: TextStyle(
                  color: accentColor1, fontSize: 30, shadows: textShadows)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Indefinitely?',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Switch(
                value: getRecurTimes() == -1,
                activeColor: accentColor1,
                activeTrackColor: Color.fromARGB((0.6 * 255).toInt(),
                    accentColor1.red, accentColor1.green, accentColor1.blue),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.white60,
                onChanged: (val) {
                  val ? setRecurTimes(-1) : setRecurTimes(1);
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) =>
                ScaleTransition(child: child, scale: animation),
            duration: Duration(milliseconds: 200),
            switchInCurve: Curves.bounceInOut,
            switchOutCurve: Curves.easeInExpo,
            child: getRecurTimes() != -1
                ? NumberPicker.integer(
                    onChanged: (val) {
                      setRecurTimes(val);
                    },
                    initialValue: getRecurTimes() ?? 1,
                    minValue: 1,
                    maxValue: 500,
                    selectedTextStyle:
                        TextStyle(color: Colors.white, fontSize: 30),
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
                : Container(height: 150),
          ),
        ),
        Spacer(flex: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                elevation: 25,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                color: accentColor1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setRecurTimes(getRecurTimes() ?? 1);
                    complete();
                  }
                },
                textColor: backgroundColor,
                child: Text('Continue', style: TextStyle(fontSize: 20))),
          ],
        ),
        Spacer(flex: 3),
      ],
    );
  }
}
