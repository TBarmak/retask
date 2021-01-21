import 'package:flutter/material.dart';
import 'package:retask/shared/constants.dart';

class EnterDueDate extends StatelessWidget {
  // Functions inherited from the parent widget
  final Function complete;
  final Function getRecurWindow;
  final Function getDueDate;
  final Function setDueDate;

  EnterDueDate(
      this.complete, this.getRecurWindow, this.getDueDate, this.setDueDate);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 2),
        // Ask for the first due date if it is recurring, otherwise just ask for the due date
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
              "When is the" +
                  (getRecurWindow() == null ? " " : " first ") +
                  "due date?",
              style: TextStyle(
                  color: accentColor1, fontSize: 40, shadows: textShadows)),
        ),
        Spacer(flex: 1),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(
                    primary: accentColor1, onPrimary: backgroundColor)),
            child: CalendarDatePicker(
              initialDate: getDueDate() ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateChanged: (val) {
                setDueDate(val);
              },
            ),
          ),
        ),
        Spacer(flex: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* Remove the "No Due Date" button for recurring tasks, because a 
            due date is required */
            getRecurWindow() == null
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: RaisedButton(
                        elevation: 25,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        color: accentColor1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          setDueDate(null);
                          complete();
                        },
                        textColor: backgroundColor,
                        child: Text('No Due Date',
                            style: TextStyle(fontSize: 20))),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                  elevation: 25,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  color: accentColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    getDueDate() ?? setDueDate(DateTime.now());
                    complete();
                  },
                  textColor: backgroundColor,
                  child: Text('Continue', style: TextStyle(fontSize: 20))),
            ),
          ],
        ),
        Spacer(flex: 2)
      ],
    );
  }
}
