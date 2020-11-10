import 'package:acnh/ui/home/pie_chart.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;

  final int caught;
  final int donated;
  final int total;

  HomeCard(
    this.title, {
    @required this.caught,
    @required this.donated,
    @required this.total,
  });

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(children: [
            PieChart(
              size: Size(54, 54),
              progress: donated / total,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 3),
                Text(
                  "$caught/$total Caught",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "$donated/$total Donated",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ]),
        ),
      );
}
