import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String text;

  Badge(this.text);

  @override
  Widget build(BuildContext context) => Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      );
}
