import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retask/constants.dart';
import 'package:retask/models/to_do.dart';
import 'package:intl/intl.dart';
import 'package:retask/screens/home/complete_to_do/complete_to_do_form.dart';
import 'package:retask/screens/home/no_to_dos.dart';
import 'package:retask/services/to_do_service.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  ToDoService toDoService = ToDoService();

  /// Show pop up menu where the user can complete the task
  void _showCompleteTaskPanel(ToDo toDo) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CompleteToDoForm(toDo);
        });
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
    final toDos = Provider.of<List<ToDo>>(context);

    /// Build a Card from a ToDo instance
    Card buildTile(context, index) {
      return Card(
        shape: Border(
            left: BorderSide(
                color: importanceColors[toDos[index].importance], width: 10)),
        child: ListTile(
            onTap: () {
              _showCompleteTaskPanel(toDos[index]);
            },
            leading: getLeading(toDos[index]),
            title: Text("${toDos[index].task}"),
            subtitle: Text(getSubtitle(toDos[index])),
            trailing: PopupMenuButton(
              onSelected: (func) {
                setState(() {
                  func();
                });
              },
              child: Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      child: Text("Edit"),
                      value: () async {
                        dynamic result = await Navigator.pushNamed(
                            context, '/edit_to_do',
                            arguments: {"toDo": toDos[index]});
                        if (result != null) {
                          toDoService.updateToDo(result["toDo"]);
                        }
                      }),
                  PopupMenuItem(
                      child: Text("Delete"),
                      value: () => toDoService.deleteToDo(toDos[index]))
                ];
              },
            )),
      );
    }

    return (toDos ?? []).length > 0
        ? ListView.builder(itemCount: toDos.length, itemBuilder: buildTile)
        : NoToDos();
  }
}
