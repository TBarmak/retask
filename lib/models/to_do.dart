import 'dart:core';

class ToDo {
  /// String representing the id of the document in the Firestore database
  String id;

  /// String representing the id of the user who created the ToDo
  String uid;

  /// Boolean representing if the task has been completed
  bool completed;

  /// String representing the task to be done
  String task;

  /// Int representing the number of times the task is to be done
  int numTimes;

  /// Int representing the number of times remaining that the task needs to be done
  int timesRemaining;

  /// Duration representing the desired duration of the task
  Duration duration;

  /// Duration representing the time remaining of the task
  Duration durationRemaining;

  /// DateTime representing first upcoming due date of the task
  DateTime dueDate;

  /// Int representing the number of times the task will recur (-1 for infinite, 0 for not recurring).
  int recurTimes;

  /// String representing the period over which the task will recur ("daily", "weekly", or "monthly")
  String recurWindow;

  /// Int representing the importance of the task (0-2: 0 = least important, 2 = most important)
  int importance;

  /// Contructor used to create ToDos that are added to the Firestore database
  ToDo(this.task,
      {this.numTimes = 1,
      this.duration,
      this.dueDate,
      this.recurTimes = 0,
      this.recurWindow,
      this.importance = 0}) {
    this.timesRemaining = numTimes;
    this.durationRemaining = duration;
    this.completed = false;
  }

  /// Constructor used to create the ToDo from the QuerySnapshot from Firestore Database
  ToDo.specifyAll(
    this.task, {
    this.id,
    this.uid,
    this.completed,
    this.numTimes = 1,
    this.timesRemaining,
    this.duration,
    this.durationRemaining,
    this.dueDate,
    this.recurTimes = 0,
    this.recurWindow,
    this.importance = 0,
  });
}
