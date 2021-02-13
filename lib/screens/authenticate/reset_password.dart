import 'package:flutter/material.dart';
import 'package:retask/screens/loading.dart';
import 'package:retask/services/auth.dart';
import 'package:retask/shared/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ResetPassword extends StatefulWidget {
  final Function toggleReset;

  ResetPassword(this.toggleReset);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = new TextEditingController();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  /// String used to store the text in the email TextFormField
  String email = '';

  /// String used to show error messages
  String error = '';

  /// Boolean used to show the loading screen
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      child: TextFormField(
                        style: TextStyle(color: backgroundColor),
                        controller: _emailController,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 25,
                            offset: Offset(0, 10))
                      ]),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: Text(error,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: accentColor1, fontSize: 14.0)),
                    ),
                    SizedBox(height: 40),
                    RaisedButton(
                      elevation: 25,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      color: accentColor1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Reset password',
                          style:
                              TextStyle(color: backgroundColor, fontSize: 15)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.sendPasswordResetEmail(email);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Account not found.';
                            });
                          } else {
                            _openPopup(context);
                            setState(() {
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ],
                )),
          );
  }

  /// Alert the user that the password reset email was sent
  void _openPopup(context) {
    List<DialogButton> buttons = [
      DialogButton(
        color: accentColor1,
        onPressed: () {
          widget.toggleReset();
          Navigator.pop(context);
        },
        child: Text(
          "Okay",
          style: TextStyle(color: backgroundColor, fontSize: 15),
        ),
      ),
    ];

    Alert(
            context: context,
            title: "Password reset email was sent!",
            buttons: buttons)
        .show();
  }
}
