import 'package:flutter/material.dart';
import 'package:retask/screens/authenticate/register.dart';
import 'package:retask/screens/authenticate/reset_password.dart';
import 'package:retask/screens/authenticate/sign_in.dart';
import 'package:retask/screens/background.dart';
import 'package:retask/shared/constants.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  /// Boolean used to show sign-in screen or register screen
  bool signIn = true;

  /// Boolean used to show the reset password screen
  /// Reset screen is shown any time reset is true (regardless of value of signIn)
  bool reset = false;

  void toggleReset() {
    setState(() {
      reset = !reset;
    });
  }

  /// Go back in the WillPopScope
  /// If the user is on the reset password screen, it will go back to the sign-in screen
  Future<bool> goBack() {
    if (reset) {
      setState(() {
        reset = false;
      });
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: goBack,
      child: Scaffold(
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
                  label: Text(!signIn || reset ? 'Sign In' : 'Register',
                      style: TextStyle(color: backgroundColor)),
                  onPressed: () {
                    setState(() {
                      if (reset) {
                        signIn = true;
                      } else {
                        signIn = !signIn;
                      }
                      reset = false;
                    });
                  },
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              Background(),
              AnimatedSwitcher(
                child: reset
                    ? ResetPassword(toggleReset)
                    : signIn
                        ? SignIn(toggleReset)
                        : Register(),
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        ScaleTransition(child: child, scale: animation),
                duration: Duration(milliseconds: 500),
                switchInCurve: Curves.bounceInOut,
                switchOutCurve: Curves.easeInExpo,
              ),
            ],
          )),
    );
  }
}
