import 'package:flutter/material.dart';

/// A list for coloring the ToDo tiles according to their importance
final List<Color> importanceColors = [Colors.green, Colors.yellow, Colors.red];

/// Options for the period over which the toDo recurs
List<String> recurWindowOptions = [
  'none',
  'daily',
  'weekly',
  'monthly',
  'annually'
];

/// Maps the recur window to the function that gets the next due date
Map<String, Function> nextDueDateFromRecurWindow = {
  'daily': (DateTime date) => DateTime(date.year, date.month, date.day + 1),
  'weekly': (DateTime date) => DateTime(date.year, date.month, date.day + 7),
  'monthy': (DateTime date) => DateTime(date.year, date.month + 1, date.day),
  'annually': (DateTime date) => DateTime(date.year + 1, date.month, date.day)
};
