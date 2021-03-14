import 'package:flutter/material.dart';
import 'dart:math' as math;


class TimerDisplay extends StatefulWidget {
  final AnimationController controller;

  const TimerDisplay({Key key, this.controller}) : super(key: key);

  @override
  _TimerDisplayState createState() => _TimerDisplayState(controller: controller);
}

class _TimerDisplayState extends State<TimerDisplay> {
  
  AnimationController controller;

  _TimerDisplayState({this.controller});

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(controller.duration.inSeconds - duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: this.controller,
          builder: (BuildContext context, Widget child) {
            return Text(this.timerString);
          },
        ),
        CustomPaint(
          size: Size(75.0, 75.0),
          painter: TimerPainter(
            animation: this.controller,
            backgroundColor: Colors.white,
            color: Theme.of(context).accentColor
          ),
        )
      ]
    );
  }
}

class TimerPainter extends CustomPainter {
  
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.height / 2.0, paint);

    // //draw arc
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;

    canvas.drawArc(
      Offset.zero & Size(size.height, size.height), 
      math.pi * 1.5, 
      - progress, 
      false, 
      paint
    );
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
          color != old.color ||
          backgroundColor != old.backgroundColor;
  }
}