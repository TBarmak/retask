import 'package:flutter/material.dart';
import 'package:retask/constants.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/services/to_do_service.dart';
import 'package:intl/intl.dart';

class ToDos extends StatefulWidget {
  @override
  _ToDosState createState() => _ToDosState();
}

class _ToDosState extends State<ToDos> {
  /// A list storing all of the ToDo items
  List<ToDo> data;

  ToDoService toDoService = ToDoService();

  @override
  void initState() {
    super.initState();
    data = toDoService.getToDos();
  }

  /// Build a Card from a ToDo instance
  Card buildTile(context, index) {
    return Card(
      shape: Border(
          left: BorderSide(
              color: importanceColors[data[index].importance], width: 10)),
      child: ListTile(
          onTap: () {},
          leading: getLeading(data[index]),
          title: Text("${data[index].task}"),
          subtitle: Text(getSubtitle(data[index])),
          trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))),
    );
  }

  /// Build the leading widget for the ListTile
  dynamic getLeading(ToDo toDo) {
    if (toDo.duration != null) {
      return SizedBox(
        width: 50,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.hourglass_top_outlined, color: Colors.grey[600]),
          Text(
              toDoService.durationToString(toDo.durationRemaining,
                  concise: true),
              style: TextStyle(color: Colors.grey[600]))
        ]),
      );
    } else if (toDo.numTimes == 1) {
      return SizedBox(
        width: 50,
        child: IconButton(
            onPressed: () {
              setState(() {
                toDoService.toggleCompleted(toDo);
              });
            },
            icon: Icon(
                toDo.completed
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: Colors.grey[600])),
      );
    } else {
      return Container(
          width: 50,
          height: 50,
          child: Center(
              child: Text(toDo.timesRemaining.toString(),
                  style: TextStyle(color: Colors.grey[600], fontSize: 20))),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 5, color: Colors.grey[600])));
    }
  }

  /// Create the string subtitle for the tile based on a ToDo instance
  String getSubtitle(ToDo toDo) {
    List parts = [];
    if (toDo.duration != null) {
      parts.add(toDoService.durationToString(toDo.duration));
    } else if (toDo.numTimes != 1) {
      parts.add(toDo.numTimes.toString() + " times");
    }
    if (toDo.dueDate != null) {
      parts.add("by " + DateFormat('M/d').format(toDo.dueDate));
    }
    if (toDo.recurTimes != 0) {
      parts.add("recurring " + toDo.recurWindow);
    }
    return parts.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue, title: Text("To-Do's")),
        body: ListView.builder(itemCount: data.length, itemBuilder: buildTile),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              dynamic result = await Navigator.pushNamed(context, '/new_to_do');
              if (result != null) {
                setState(() {
                  toDoService.addTodo(result['toDo']);
                });
              }
            },
            child: Icon(Icons.add)));
  }
}
