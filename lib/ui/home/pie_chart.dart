import 'dart:math';

import 'package:flutter/material.dart';

class PieChart extends StatefulWidget {
  final Size size;
  final double progress;

  PieChart({
    @required this.size,
    @required this.progress,
  });

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener(() => setState(() {}));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: widget.size,
        painter: _PieChartPainter(_animation().value),
      );

  Animation<double> _animation() => Tween<double>(
        begin: 0,
        end: widget.progress,
      ).animate(
        CurvedAnimation(
          curve: Curves.fastOutSlowIn,
          parent: _controller,
        ),
      );
}

class _PieChartPainter extends CustomPainter {
  final double progress;

  _PieChartPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.drawOval(Rect.fromLTWH(0, 0, size.width, size.height),
        paint..color = Colors.blue);

    canvas.drawOval(
        Rect.fromLTWH(size.width * 0.1, size.height * 0.1, size.width * 0.8,
            size.height * 0.8),
        paint..color = Colors.white);

    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), -90 * pi / 180,
        360 * progress * pi / 180, true, paint..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_PieChartPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
