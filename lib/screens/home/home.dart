import 'package:flutter/material.dart';
import 'package:retask/services/auth.dart';
import 'package:retask/screens/background.dart';
import 'package:retask/shared/constants.dart';
import 'package:retask/shared/shared.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          actions: [
            Container(
              decoration: BoxDecoration(
                  color: accentColor1,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: FlatButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.person, color: backgroundColor),
                  label:
                      Text('Logout', style: TextStyle(color: backgroundColor))),
            )
          ],
        ),
        body: Stack(
          children: [
            Background(),
            Column(
              children: [
                Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 80, 0),
                  child: Text(getWelcomeMessage(),
                      style: TextStyle(
                          color: accentColor1,
                          fontSize: 35,
                          shadows: [
                            Shadow(
                                offset: Offset(0, 10),
                                blurRadius: 25,
                                color: Colors.black38)
                          ])),
                ),
                Spacer(flex: 10),
                RaisedButton(
                    elevation: 25,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    color: accentColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/to_dos');
                    },
                    child: Text("My To-Do's",
                        style:
                            TextStyle(color: backgroundColor, fontSize: 20))),
                Spacer(flex: 2),
              ],
            ),
          ],
        ));
  }
}
