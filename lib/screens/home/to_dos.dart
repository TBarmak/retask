import 'package:flutter/material.dart';
import 'package:retask/models/my_user.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/screens/home/to_do_list.dart';
import 'package:retask/services/to_do_service.dart';

import 'package:provider/provider.dart';

class ToDos extends StatefulWidget {
  @override
  _ToDosState createState() => _ToDosState();
}

class _ToDosState extends State<ToDos> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    ToDoService toDoService = ToDoService(uid: user.uid);

    return StreamProvider<List<ToDo>>.value(
      value: toDoService.toDos,
      child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.blue, title: Text("To-Do's")),
          body: ToDoList(),
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                dynamic result =
                    await Navigator.pushNamed(context, '/new_to_do');
                if (result != null) {
                  setState(() {
                    toDoService.addToDo(result['toDo']);
                  });
                }
              },
              child: Icon(Icons.add))),
    );
  }
}
