import 'dart:core';

class ToDo {
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
}
