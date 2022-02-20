import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  final String m1, m2;
  const Graph({Key? key, required this.m1, required this.m2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Color.fromARGB(255, 231, 32, 92),
      Color.fromARGB(255, 124, 21, 64),
    ];
    return LineChart(LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color.fromARGB(255, 129, 129, 129),
            strokeWidth: 2,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
              color: Color.fromARGB(255, 129, 129, 129),
              strokeWidth: 2,
              dashArray: [1, 2]);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return m1;
              case 8:
                return m2;
            }
            return '';
          },
          margin: 2,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '5';
              case 3:
                return '7';
              case 5:
                return '12';
            }
            return '';
          },
          reservedSize: 32,
          margin: 1,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border:
              Border.all(color: Color.fromARGB(255, 148, 148, 148), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    ));
  }
}
