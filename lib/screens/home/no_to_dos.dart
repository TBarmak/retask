import 'package:flutter/material.dart';
import 'package:retask/shared/shared.dart';

class NoToDos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double fullWidth = screenWidth(context);
    final double fullHeight = screenHeight(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(
        children: [
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text("You have nothing to do :)",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[500], fontSize: 70)),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text("Click here to create a new to-do",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[500], fontSize: 30)),
              )
            ],
          )),
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
    Paint linePaint = Paint();
    linePaint.strokeWidth = 7;
    linePaint.color = Colors.grey[500];
    linePaint.style = PaintingStyle.stroke;
    linePaint.strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(screenWidth * 0.5, screenHeight * 0.71),
        Offset(screenWidth * 0.75, screenHeight * 0.77), linePaint);
    canvas.drawCircle(Offset(screenWidth * 0.893, screenHeight * 0.819),
        screenWidth * 0.09, linePaint);

    var path = Path();
    path.moveTo(screenWidth * 0.65, screenHeight * 0.78);
    path.lineTo(screenWidth * 0.75, screenHeight * 0.77);
    path.lineTo(screenWidth * 0.7, screenHeight * 0.72);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
