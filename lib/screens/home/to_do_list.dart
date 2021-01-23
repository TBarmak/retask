import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retask/screens/loading.dart';
import 'package:retask/shared/constants.dart';
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
          return SingleChildScrollView(
            child: Container(
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0))),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        CompleteToDoForm(toDo),
                        SizedBox(height: 30),
                      ],
                    ))),
          );
        });
  }

  /// Build the leading widget for the ListTile
  dynamic getLeading(ToDo toDo) {
    if (toDo.duration != null) {
      return Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
        width: 60,
        height: 60,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.hourglass_top_outlined, color: accentColor1),
          Text(
              toDoService.durationToString(toDo.durationRemaining,
                  concise: true),
              style: TextStyle(color: accentColor1))
        ]),
      );
    } else if (toDo.numTimes == 1) {
      return Container(
        width: 60,
        height: 60,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
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
                color: accentColor1)),
      );
    } else {
      return Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
        width: 60,
        height: 60,
        padding: EdgeInsets.all(5),
        child: Container(
            child: Center(
                child: Text(toDo.timesRemaining.toString(),
                    style: TextStyle(color: accentColor1, fontSize: 20))),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 5, color: accentColor1))),
      );
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
      parts.add("recurring " +
          toDo.recurWindow +
          (toDo.recurTimes == -1
              ? " indefinitely"
              : " " + toDo.recurTimes.toString() + " times"));
    }
    return parts.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    final toDos = Provider.of<List<ToDo>>(context);

    // Check if the due dates of recurring ToDos have passed
    if (toDos != null) {
      for (var toDo in toDos) {
        toDoService.recur(toDo);
      }
    }

    /// Put completed tasks at the bottom, and sort alphabetically by task
    int sortCompleted(a, b) {
      if (a.completed && !b.completed) {
        return 1;
      } else if (b.completed && !a.completed) {
        return -1;
      } else {
        return a.task.compareTo(b.task);
      }
    }

    // Move completed tasks to the bottom of the list
    if (toDos != null) {
      toDos.sort(sortCompleted);
    }

    /// Build a Card from a ToDo instance
    Widget buildTile(context, index) {
      return Opacity(
        opacity: toDos[index].completed ? 0.6 : 1,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ClipPath(
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: Container(
                decoration: toDos[index].importance != 0
                    ? BoxDecoration(
                        border: Border(
                            left: BorderSide(color: accentColor1, width: 10)))
                    : BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.white, width: 10))),
                child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    onTap: () {
                      _showCompleteTaskPanel(toDos[index]);
                    },
                    leading: getLeading(toDos[index]),
                    title: Text("${toDos[index].task}",
                        style: TextStyle(color: backgroundColor)),
                    subtitle: Text(getSubtitle(toDos[index]),
                        style: TextStyle(color: backgroundColorTranslucent)),
                    trailing: PopupMenuButton(
                      onSelected: (func) {
                        setState(() {
                          func();
                        });
                      },
                      child: Column(
                        children: [
                          Icon(Icons.more_vert),
                        ],
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              child: Text("Edit",
                                  style: TextStyle(color: backgroundColor)),
                              value: () async {
                                dynamic result = await Navigator.pushNamed(
                                    context, '/edit_to_do',
                                    arguments: {"toDo": toDos[index]});
                                if (result != null) {
                                  toDoService.updateToDo(result["toDo"]);
                                }
                              }),
                          PopupMenuItem(
                              child: Text("Delete",
                                  style: TextStyle(color: backgroundColor)),
                              value: () => toDoService.deleteToDo(toDos[index]))
                        ];
                      },
                    )),
              ),
            ),
          ),
        ),
      );
    }

    if (toDos == null) {
      return Loading();
    }
    return toDos.length > 0
        ? ListView.builder(itemCount: toDos.length, itemBuilder: buildTile)
        : NoToDos();
  }
}
