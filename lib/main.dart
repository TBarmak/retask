import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retask/models/my_user.dart';
import 'package:retask/screens/home/to_dos.dart';
import 'package:retask/screens/wrapper.dart';
import 'package:retask/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        routes: {'/': (context) => Wrapper(), '/todos': (context) => ToDos()},
      ),
    );
  }
}
