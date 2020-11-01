import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String text;

  Badge(this.text);

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(minWidth: 16),
        child: Container(
          height: 16,
          padding: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ),
      );
}
