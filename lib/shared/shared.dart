import 'package:flutter/material.dart';

// Get the dimensions of the screen
Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

// Get the height of the screen
double screenHeight(BuildContext context, {double factor = 1}) {
  return screenSize(context).height * factor;
}

// Get the width of the screen
double screenWidth(BuildContext context, {double factor = 1}) {
  return screenSize(context).width / factor;
}
