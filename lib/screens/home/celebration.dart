import 'package:flutter/material.dart';
import 'package:retask/shared/constants.dart';

class Celebration extends StatelessWidget {
  final Function setCelebrate;

  Celebration(this.setCelebrate);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Color(0x77000000)),
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/confetti.gif"),
                    fit: BoxFit.cover))),
        SafeArea(
          child: Column(
            children: [
              Spacer(flex: 2),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text("Congratulations on finishing your task!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40, color: backgroundColor))),
              Spacer(flex: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    elevation: 5,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    color: accentColor1,
                    textColor: backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text("Yay!", style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      setCelebrate(false);
                    },
                  ),
                ],
              ),
              Spacer(flex: 1)
            ],
          ),
        ),
      ],
    );
  }
}
