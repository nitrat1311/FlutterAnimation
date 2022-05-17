import 'package:flutter/material.dart';

// Необходимо реализовать функционал передвижения красного квадрата по нажатию на кнопки (влево, вправо).
// Требования:
// 1. При нажатии кнопки "вправо" квадрат будет перемещаться к правой границе экрана;
// 2. При нажатии кнопки "влево" квадрат будет перемещаться к левой границе экрана;
// 3. Если квадрат находится у левой границы экрана, кнопка "влево" находится в disabled состоянии;
// 4. Если квадрат находится у правой границы экрана, кнопка "вправо" находится в disabled состоянии;
// 5. Перемещение должно быть анимированным, длительность анимации составляет одну секунду;
// 6. Во время перемещения обе кнопки переходят в disabled состояние.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SquareAnimation(),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation> {
  static const squareSize = 50.0;
  double squereOffset = 50.0;

  bool rightButtonPressed = false;
  bool leftButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width,
          height: 500,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedPositioned(
                right: !rightButtonPressed && !leftButtonPressed
                    ? width / 2 - squareSize / 2
                    : squereOffset,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  width: squareSize,
                  height: squareSize,
                  color: Colors.red,
                ),
                onEnd: (() {
                  checkIfButtonsPressed();
                }),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed:
                    (rightButtonPressed) ? null : () => pressRightButton(),
                child: const Text("To the left")),
            ElevatedButton(
                onPressed: (leftButtonPressed) ? null : () => pressLeftButton(),
                child: const Text("To the right"))
          ],
        )
      ],
    );
  }

  checkIfButtonsPressed() {
    setState(() {
      if (squereOffset == 0) {
        rightButtonPressed = false;
      }
      if (squereOffset == MediaQuery.of(context).size.width - squareSize) {
        leftButtonPressed = false;
      }
    });
  }

  pressLeftButton() {
    setState(() {
      squereOffset = 0;
      rightButtonPressed = true;
      leftButtonPressed = true;
    });
  }

  pressRightButton() {
    setState(() {
      squereOffset = MediaQuery.of(context).size.width - squareSize;
      leftButtonPressed = true;
      rightButtonPressed = true;
    });
  }
}
