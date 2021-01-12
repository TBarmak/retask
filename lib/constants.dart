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
