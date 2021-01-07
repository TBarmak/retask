import 'package:retask/models/to_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoService {
  final String uid;
  ToDoService({this.uid});

  /// Reference to toDo collection reference
  final CollectionReference toDosCollection =
      FirebaseFirestore.instance.collection('toDos');

  /// Creates a Map<String, dynamic> of a ToDo where each key in the map is a field of the ToDo object
  Map<String, dynamic> toDoToMap(ToDo toDo) {
    return {
      "task": toDo.task,
      "uid": toDo.uid,
      "completed": toDo.completed,
      "numTimes": toDo.numTimes,
      "timesRemaining": toDo.timesRemaining,
      // duration is stored as the number of seconds in the Duration, if it is not null
      "duration": toDo.duration == null ? null : toDo.duration.inSeconds,
      // durationRemaining is stored as the number of seconds in the Duration, if it is not null
      "durationRemaining": toDo.durationRemaining == null
          ? null
          : toDo.durationRemaining.inSeconds,
      // dueDate is stored as a string
      "dueDate": toDo.dueDate.toString(),
      "recurTimes": toDo.recurTimes,
      "recurWindow": toDo.recurWindow,
      "importance": toDo.importance
    };
  }

  /// Get a list of ToDos from a QuerySnapshot
  List<ToDo> _toDoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ToDo.specifyAll(
        doc.data()['task'],
        id: doc.id,
        uid: doc.data()['uid'],
        completed: doc.data()['completed'],
        numTimes: doc.data()['numTimes'],
        timesRemaining: doc.data()['timesRemaining'],
        // duration must be constructed from the number of seconds
        duration: doc.data()['duration'] == null
            ? null
            : Duration(seconds: doc.data()['duration']),
        // durationRemaining must be constructed from the number of seconds
        durationRemaining: doc.data()['durationRemaining'] == null
            ? null
            : Duration(seconds: doc.data()['durationRemaining']),
        // dueDate string must be parsed
        dueDate: DateTime.parse(doc.data()['dueDate']),
        recurTimes: doc.data()['recurTimes'],
        recurWindow: doc.data()['recurWindow'],
        importance: doc.data()['importance'],
      );
    }).toList();
  }

  /// Stream for list of ToDos filtered by the uid of the user that is logged in
  Stream<List<ToDo>> get toDos {
    return toDosCollection
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map(_toDoListFromSnapshot);
  }

  /// Add a ToDo to the Firestore database
  void addToDo(ToDo toDo) async {
    toDo.uid = uid;
    toDosCollection.add(toDoToMap(toDo));
  }

  /// Delete a ToDo from the Firestore database
  void deleteToDo(ToDo toDo) {
    toDosCollection.doc(toDo.id).delete();
  }

  /// Toggle the completed attribute of a ToDo instance in the Firestore Database
  void toggleCompleted(ToDo toDo) {
    toDosCollection.doc(toDo.id).update({"completed": !toDo.completed});
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
}
