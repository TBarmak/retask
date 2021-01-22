import 'package:flutter/material.dart';
import 'package:retask/shared/constants.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Spacer(flex: 1),
          Image.asset("assets/check.png", color: accentColor2),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
