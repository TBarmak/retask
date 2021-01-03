import 'package:retask/models/to_do.dart';

// Sample list of ToDos for testing before connecting to Firebase
final List<ToDo> sampleData = [
  ToDo("Read a book",
      numTimes: 1,
      dueDate: DateTime.parse('2021-01-09'),
      recurTimes: -1,
      recurWindow: "weekly",
      importance: 1),
  ToDo("Read",
      duration: Duration(hours: 5, minutes: 30),
      dueDate: DateTime.parse('2021-01-09'),
      recurTimes: -1,
      recurWindow: "weekly",
      importance: 1),
  ToDo("Practice juggling",
      duration: Duration(hours: 2, minutes: 13), importance: 1),
  ToDo("End world hunger",
      numTimes: 1,
      dueDate: DateTime.parse('2021-01-09'),
      recurTimes: 0,
      importance: 2),
  ToDo("Play chess",
      duration: Duration(hours: 2),
      dueDate: DateTime.parse('2021-01-09'),
      recurTimes: 3,
      recurWindow: "weekly"),
  ToDo("Exercise",
      numTimes: 5,
      dueDate: DateTime.parse('2021-01-09'),
      recurTimes: -1,
      recurWindow: "weekly",
      importance: 2),
  ToDo("Code",
      duration: Duration(hours: 1),
      dueDate: DateTime.parse('2021-01-09'),
      recurTimes: 4,
      recurWindow: "daily",
      importance: 2),
  ToDo("Make money",
      duration: Duration(minutes: 30, seconds: 30),
      dueDate: DateTime.parse('2021-01-09'),
      recurTimes: -1,
      recurWindow: "daily",
      importance: 2),
];

/// Get a list of ToDos
List<ToDo> getToDos() {
  return sampleData;
}

/// Toggle the completed attribute of a ToDo instance
void toggleCompleted(ToDo todo) {
  todo.completed = !todo.completed;
}

// TODO: Implement sorting methods to sort by importance and due date

/// Convert a duration to the form "x hr(s) y min", concise arg makes the output shorter when set to true
String durationToString(Duration duration, {bool concise = false}) {
  List parts = duration.toString().split(':');
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  int seconds = int.parse(parts[2].split('.')[0]);
  if (hours > 0) {
    if (minutes > 0) {
      if (concise) {
        return (hours + (minutes / 60)).toStringAsFixed(1) +
            (hours == 1 ? " hr" : " hrs");
      }
      return hours.toString() +
          (hours == 1 ? " hr " : " hrs ") +
          minutes.toString() +
          " min";
    }
    return hours.toString() + (hours == 1 ? " hr" : " hrs");
  } else if (minutes > 0) {
    if (seconds > 0 && !concise) {
      return minutes.toString() + " min " + seconds.toString() + " sec";
    }
    return minutes.toString() + " min";
  } else {
    return seconds.toString() + " sec";
  }
}
