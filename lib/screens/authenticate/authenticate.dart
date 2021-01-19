import 'package:flutter/material.dart';
import 'package:retask/screens/authenticate/register.dart';
import 'package:retask/screens/authenticate/sign_in.dart';
import 'package:retask/shared/constants.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  /// Boolean used to show sign-in screen or register screen
  bool signIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                icon: Icon(Icons.person, color: backgroundColor),
                label: Text(signIn ? 'Register' : 'Sign In',
                    style: TextStyle(color: backgroundColor)),
                onPressed: () {
                  setState(() {
                    signIn = !signIn;
                  });
                },
              ),
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
            AnimatedSwitcher(
              child: signIn ? SignIn() : Register(),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  ScaleTransition(child: child, scale: animation),
              duration: Duration(milliseconds: 500),
              switchInCurve: Curves.bounceInOut,
              switchOutCurve: Curves.easeInExpo,
            ),
          ],
        ));
  }
}
