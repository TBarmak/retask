import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retask/models/my_user.dart';
import 'package:retask/screens/authenticate/authenticate.dart';
import 'package:retask/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return AnimatedSwitcher(
      child: user == null ? Authenticate() : Home(),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          ScaleTransition(child: child, scale: animation),
      duration: Duration(milliseconds: 500),
      switchInCurve: Curves.bounceInOut,
      switchOutCurve: Curves.easeInExpo,
    );
  }
}
