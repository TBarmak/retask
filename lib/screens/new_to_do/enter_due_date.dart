import 'package:flutter/material.dart';

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
        // Ask for the first due date if it is recurring, otherwise just ask for the due date
        Text(
            "When is the" +
                (getRecurWindow() == null ? " " : " first ") +
                "due date?",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: CalendarDatePicker(
            initialDate: getDueDate() ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateChanged: (val) {
              setDueDate(val);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* Remove the "No Due Date" button for recurring tasks, because a 
            due date is required */
            getRecurWindow() == null
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: RaisedButton(
                        onPressed: () {
                          setDueDate(null);
                          complete();
                        },
                        color: Colors.white,
                        child: Text('No Due Date',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 20))),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                  onPressed: () {
                    complete();
                  },
                  color: Colors.white,
                  child: Text('Continue',
                      style: TextStyle(color: Colors.blue, fontSize: 20))),
            ),
          ],
        )
      ],
    );
  }
}
