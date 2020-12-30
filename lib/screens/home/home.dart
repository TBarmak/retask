import 'package:flutter/material.dart';
import 'package:retask/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: [
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person, color: Colors.white),
              label: Text('Logout', style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
