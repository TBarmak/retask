import 'package:flutter/material.dart';
import 'package:retask/services/auth.dart';
import 'package:retask/shared/constants.dart';

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
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/check.png"),
                      fit: BoxFit.fitWidth)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  child: Text("You're looking awfully handsome today",
                      style: TextStyle(
                          color: accentColor1,
                          fontSize: 40,
                          shadows: [
                            Shadow(
                                offset: Offset(0, 10),
                                blurRadius: 25,
                                color: Colors.black38)
                          ])),
                ),
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
                        style: TextStyle(color: backgroundColor, fontSize: 15)))
              ],
            ),
          ],
        ));
  }
}
