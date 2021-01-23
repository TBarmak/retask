import 'package:flutter/material.dart';
import "dart:math";
import 'package:retask/shared/constants.dart';

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

/// Randomly choose a welcome message and return it
String getWelcomeMessage() {
  var random = new Random();

  return welcomeMessages[random.nextInt(welcomeMessages.length)];
}
