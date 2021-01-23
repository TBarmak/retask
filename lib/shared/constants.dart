import 'package:flutter/material.dart';

/// A list for coloring the ToDo tiles according to their importance
final List<Color> importanceColors = [Colors.green, Colors.yellow, Colors.red];

/// A list of phrases associated with each level of importance
List<String> importanceWords = ["procrastinate?", "meh", "just DO IT!"];

/// Options for the period over which the toDo recurs
List<String> recurWindowOptions = [
  'none',
  'daily',
  'weekly',
  'monthly',
  'annually'
];

/// Converts time periods from adverb form to noun
Map frequencyToPeriod = {
  'daily': 'day',
  'weekly': 'week',
  'monthly': 'month',
  'annually': 'year'
};

/// Maps the recur window to the function that gets the next due date
Map<String, Function> nextDueDateFromRecurWindow = {
  'daily': (DateTime date) => DateTime(date.year, date.month, date.day + 1),
  'weekly': (DateTime date) => DateTime(date.year, date.month, date.day + 7),
  'monthy': (DateTime date) => DateTime(date.year, date.month + 1, date.day),
  'annually': (DateTime date) => DateTime(date.year + 1, date.month, date.day)
};

// Colors for the theme
const Color backgroundColor = Color(0xff2c365e);
const Color backgroundColorTranslucent = Color(0x992c365e);
const Color accentColor1 = Color(0xff8acdea);
const Color accentColor2 = Color(0xff66ff00);

/// Decoration for all TextFormFields
const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintStyle: TextStyle(color: backgroundColorTranslucent),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.white, width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: accentColor1, width: 2.0)),
    errorStyle: TextStyle(color: accentColor1),
    focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: accentColor1, width: 2.0)),
    errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: accentColor1, width: 2.0)));

/// Shadows for text in widgets for creating a new to-do
const textShadows = [
  Shadow(offset: Offset(0, 10), blurRadius: 25, color: Colors.black38)
];

/// Messages presented on the home screen to inspire the user
const List<String> welcomeMessages = [
  "You're looking awfully good today.",
  "Amateurs sit and wait for inspiration, the rest of us just get up and go to work.",
  "Why do anything unless it is going to be great?",
  "The way to get started is to quit talking and begin doing.",
  "The secret of getting ahead is getting started."
];
