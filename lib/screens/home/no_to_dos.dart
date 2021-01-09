import 'package:flutter/material.dart';

class NoToDos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Text('You have nothing to do :)',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 60, letterSpacing: 2, color: Colors.grey[500])),
    ));
  }
}
