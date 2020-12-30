import 'package:flutter/material.dart';

class ToDos extends StatefulWidget {
  @override
  _ToDosState createState() => _ToDosState();
}

class _ToDosState extends State<ToDos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue, title: Text('To-Dos')),
        body: Text('Here are your To-Dos'),
        floatingActionButton:
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)));
  }
}
