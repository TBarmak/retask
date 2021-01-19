import 'package:flutter/material.dart';
import 'package:retask/models/my_user.dart';
import 'package:retask/models/to_do.dart';
import 'package:retask/screens/home/to_do_list.dart';
import 'package:retask/services/to_do_service.dart';

import 'package:provider/provider.dart';
import 'package:retask/shared/constants.dart';
import 'package:retask/shared/shared.dart';

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
        backgroundColor: backgroundColor,
        appBar: AppBar(backgroundColor: backgroundColor, elevation: 0.0),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/check.png"),
                      fit: BoxFit.fitWidth)),
            ),
            ToDoList(),
            Positioned(
              width: screenWidth(context) * 0.14,
              height: screenWidth(context) * 0.14,
              left: screenWidth(context) * 0.893 - screenWidth(context) * 0.07,
              top: screenHeight(context) * 0.819 - screenWidth(context) * 0.07,
              child: FloatingActionButton(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/new_to_do');
                    if (result != null) {
                      setState(() {
                        toDoService.addToDo(result['toDo']);
                      });
                    }
                  },
                  backgroundColor: accentColor1,
                  child: Icon(Icons.add, color: backgroundColor)),
            )
          ],
        ),
      ),
    );
  }
}
