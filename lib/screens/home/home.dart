import 'package:flutter/material.dart';
import 'package:retask/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Welcome'),
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You're looking awfully handsome today",
                    style: TextStyle(fontSize: 40)),
                RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/to_dos');
                    },
                    color: Colors.blue,
                    child: Text("My To-Do's",
                        style: TextStyle(color: Colors.white)))
              ],
            ),
          ),
        ));
  }
}
