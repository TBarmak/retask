import 'package:flutter/material.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/screens/new_to_do/enter_due_date.dart';
import 'package:retask/screens/new_to_do/enter_duration.dart';
import 'package:retask/screens/new_to_do/enter_num_times.dart';
import 'package:retask/screens/new_to_do/enter_recur_window.dart';
import 'package:retask/screens/new_to_do/enter_recurring.dart';
import 'package:retask/screens/new_to_do/enter_task.dart';
import 'package:retask/screens/new_to_do/enter_time_based.dart';
import 'package:retask/shared/constants.dart';

class NewTodo extends StatefulWidget {
  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  /// Stores if the task has been entered
  bool taskEntered = false;

  /// Stores the task for the ToDo
  String task;

  /// Stores the importance of the task (0 - 2)
  int importance;

  /// Stores if the user has entered whether or not the task is recurring
  bool recurringEntered = false;

  /// Stores whether or not the task is recurring
  bool isRecurring;

  /// Stores whether or not the user has entered the recurWindow (and the number of times it will recur)
  bool recurWindowEntered = false;

  /// Stores the number of times the task will recur
  int recurTimes;

  /// Stores the window over which the task will recur (daily, weekly, etc.)
  String recurWindow;

  /// Stores if the user has entered the due date
  bool dueDateEntered = false;

  /// Stores the due date of the task
  DateTime dueDate;

  /// Stores whether or not the user has indicated if the task is time-based (has a duration)
  bool timeBasedEntered = false;

  /// Stores whether or not the task is time-based
  bool timeBased;

  /// Stores the number of times the task is to be completed
  int numTimes;

  /// Stores the duration of the task
  Duration duration;

  /// Stores the number of hours for the duration
  int hours;

  /// Stores the number of minutes for the duration
  int minutes;

  /// Stores the error message shown to the user on some child widgets
  String error = "";

  String getTask() {
    return task;
  }

  void setTask(String currTask) {
    setState(() {
      task = currTask;
    });
  }

  int getImportance() {
    return importance;
  }

  void setImportance(int currImportance) {
    setState(() {
      importance = currImportance;
    });
  }

  void setIsRecurring(bool recurring) {
    isRecurring = recurring;
  }

  String getRecurWindow() {
    return recurWindow;
  }

  void setRecurWindow(String recWindow) {
    setState(() {
      recurWindow = recWindow;
    });
  }

  int getRecurTimes() {
    return recurTimes;
  }

  void setRecurTimes(int recTimes) {
    setState(() {
      recurTimes = recTimes;
    });
  }

  DateTime getDueDate() {
    return dueDate;
  }

  void setDueDate(DateTime date) {
    setState(() {
      dueDate = date;
    });
  }

  bool getTimeBased() {
    return timeBased;
  }

  void setTimeBased(bool isTimeBased) {
    timeBased = isTimeBased;
  }

  int getNumTimes() {
    return numTimes;
  }

  void setNumTimes(int times) {
    setState(() {
      numTimes = times;
    });
  }

  int getHours() {
    return hours;
  }

  void setHours(hour) {
    setState(() {
      hours = hour;
    });
  }

  int getMinutes() {
    return minutes;
  }

  void setMinutes(minute) {
    setState(() {
      minutes = minute;
    });
  }

  String getError() {
    return error;
  }

  void setError(err) {
    setState(() {
      error = err;
    });
  }

  /// Controls the functionality of the back button
  void goBack() {
    // If on the first page, pop back to the list of To-Do's
    if (!taskEntered) {
      Navigator.pop(context);
      // If on the isRecurring? page, go back to the page to enter the task
    } else if (!recurringEntered) {
      setState(() {
        isRecurring = null;
        taskEntered = false;
      });
      // If on the recurWindow? page, go back to the isRecurring? page
    } else if (isRecurring && !recurWindowEntered) {
      setState(() {
        recurringEntered = false;
        recurWindow = null;
        recurTimes = null;
      });
      // If on the dueDate? page
    } else if (!dueDateEntered) {
      setState(() {
        // go to the recurWindow? page if the recurWindow was entered
        if (recurWindowEntered) {
          setState(() {
            recurWindowEntered = false;
          });
          // otherwise, go to the isRecurring? page
        } else {
          setState(() {
            recurringEntered = false;
            recurTimes = null;
          });
        }
        dueDate = DateTime.now();
      });
      // if on the timeBased? page, go to the dueDate? page
    } else if (!timeBasedEntered) {
      setState(() {
        timeBased = null;
        dueDateEntered = false;
      });
      // otherwise go to the timeBased? page
    } else {
      print("Here");
      setState(() {
        timeBased = null;
        timeBasedEntered = false;
      });
    }
  }

  /// gets the appropriate screen to request information about the ToDo from the user
  dynamic getMenuScreen() {
    if (!taskEntered) {
      void complete() {
        setState(() {
          taskEntered = true;
          importance = importance ?? 0;
        });
      }

      return EnterTask(
          complete, getTask, setTask, getImportance, setImportance);
    } else if (!recurringEntered) {
      void complete() {
        setState(() {
          recurringEntered = true;
        });
      }

      return EnterRecurring(complete, setIsRecurring, setRecurTimes);
    } else if (isRecurring && !recurWindowEntered) {
      void complete() {
        setState(() {
          recurTimes = recurTimes ?? 1;
          recurWindowEntered = true;
        });
      }

      return EnterRecurWindow(complete, getRecurWindow, setRecurWindow,
          getRecurTimes, setRecurTimes, getError, setError);
    } else if (!dueDateEntered) {
      void complete() {
        setState(() {
          dueDate = dueDate;
          dueDateEntered = true;
        });
      }

      return EnterDueDate(complete, getRecurWindow, getDueDate, setDueDate);
    } else if (!timeBasedEntered) {
      void complete() {
        setState(() {
          timeBasedEntered = true;
        });
      }

      return EnterTimeBased(complete, setTimeBased);
    } else if (!timeBased) {
      void complete() {
        ToDo result = ToDo(task,
            numTimes: numTimes ?? 1,
            dueDate: dueDate,
            recurTimes: recurTimes,
            recurWindow: recurWindow,
            importance: importance);
        Navigator.pop(context, {'toDo': result});
      }

      return EnterNumTimes(
          complete, getRecurWindow, getNumTimes, setNumTimes, getTask);
    } else {
      void complete() {
        duration = Duration(hours: hours ?? 1, minutes: minutes ?? 0);
        ToDo result = ToDo(task,
            duration: duration,
            dueDate: dueDate,
            recurTimes: recurTimes,
            recurWindow: recurWindow,
            importance: importance);
        Navigator.pop(context, {'toDo': result});
      }

      return EnterDuration(complete, getHours, setHours, getMinutes, setMinutes,
          getError, setError, getTask, getRecurWindow);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/check.png"),
                      fit: BoxFit.fitWidth)),
            ),
            SafeArea(
              child: Column(
                children: [
                  Row(children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          goBack();
                        })
                  ]),
                ],
              ),
            ),
            SafeArea(
              child: AnimatedSwitcher(
                child: getMenuScreen(),
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        ScaleTransition(child: child, scale: animation),
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
              ),
            )
          ],
        ));
  }
}
