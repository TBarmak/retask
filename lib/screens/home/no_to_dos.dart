import 'package:flutter/material.dart';
import 'package:retask/shared/constants.dart';
import 'package:retask/shared/shared.dart';
import 'dart:math';

class NoToDos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double fullWidth = screenWidth(context);
    final double fullHeight = screenHeight(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(
        children: [
          Positioned(
            left: screenWidth(context) * 0.05,
            child: SizedBox(
              width: screenWidth(context) * 0.7,
              child: Text("You have nothing to do :)",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: accentColor1, fontSize: 70, shadows: [
                    Shadow(
                        offset: Offset(0, 10),
                        blurRadius: 25,
                        color: Colors.black38)
                  ])),
            ),
          ),
          Positioned(
            top: screenHeight(context) * 0.5,
            left: screenWidth(context) * 0.6,
            child: SizedBox(
              width: screenWidth(context) * 0.4,
              child: Text("Create a new to-do",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: accentColor1, fontSize: 30, shadows: [
                    Shadow(
                        offset: Offset(0, 10),
                        blurRadius: 25,
                        color: Colors.black38)
                  ])),
            ),
          ),
          CustomPaint(
              painter: MyPainter(fullWidth, fullHeight),
              size: Size(constraints.maxWidth, constraints.maxHeight)),
        ],
      );
    });
  }
}

class MyPainter extends CustomPainter {
  final double screenWidth;
  final double screenHeight;

  MyPainter(this.screenWidth, this.screenHeight);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = screenWidth * 0.09;
    Paint linePaint = Paint();

    linePaint.strokeWidth = 7;
    linePaint.color = accentColor2;
    linePaint.style = PaintingStyle.stroke;
    linePaint.strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(screenWidth * 0.8, screenHeight * 0.62),
        // Get a point on the circle
        Offset(
            screenWidth * 0.87,
            -1 *
                    sqrt(pow(radius, 2) -
                        pow(screenWidth * 0.87 - screenWidth * 0.893, 2)) +
                screenHeight * 0.819),
        linePaint);
    canvas.drawCircle(
        Offset(screenWidth * 0.893, screenHeight * 0.819), radius, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
