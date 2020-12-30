import 'package:flutter/material.dart';
import 'package:retask/services/auth.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  /// Boolean used to show sign-in screen or register screen
  bool signIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text(signIn ? 'Sign In' : 'Sign Up'),
        actions: [
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(signIn ? 'Register' : 'Sign In',
                style: TextStyle(color: Colors.white)),
            onPressed: () {
              setState(() {
                signIn = !signIn;
                _emailController.clear();
                _passwordController.clear();
                error = '';
                email = '';
                password = '';
              });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  validator: (val) =>
                      val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(signIn ? 'Sign in' : 'Register',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (signIn) {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() => error =
                              'Could not sign in with those credentials');
                        }
                      } else {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() => error = 'Please supply a valid email');
                        }
                      }
                    }
                  },
                ),
                SizedBox(height: 12),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0))
              ],
            )),
      ),
    );
  }
}
