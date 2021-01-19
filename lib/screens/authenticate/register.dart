import 'package:flutter/material.dart';
import 'package:retask/screens/loading.dart';
import 'package:retask/services/auth.dart';
import 'package:retask/shared/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
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
                            val.isEmpty ? 'Enter an email' : null,
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
                    Container(
                      child: TextFormField(
                        style: TextStyle(color: backgroundColor),
                        controller: _passwordController,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ characters long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
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
                          style:
                              TextStyle(color: accentColor1, fontSize: 14.0)),
                    ),
                    SizedBox(height: 12),
                    RaisedButton(
                      elevation: 25,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      color: accentColor1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Register',
                          style:
                              TextStyle(color: backgroundColor, fontSize: 15)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error =
                                  'Could not register with those credentials.';
                            });
                          }
                        }
                      },
                    ),
                  ],
                )),
          );
  }
}
