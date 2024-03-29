import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:retask/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        child: Center(
            child: SpinKitChasingDots(
          color: accentColor1,
          size: 50.0,
        )));
  }
}
