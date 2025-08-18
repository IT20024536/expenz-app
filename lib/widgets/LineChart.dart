import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MyLineChart extends StatefulWidget {
  const MyLineChart({super.key});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {

  List<Color> gradientColors = [
    kMainColor,
    kMainColor.withOpacity(0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget> [
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
              padding: EdgeInsets.only(
                right: 18,
                left: 12,
                top: 12,
                bottom: 12,
              ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta){
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 10,
      color: kGrey,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('Shopping', style: style);
        break;
      case 5:
        text = const Text('Transport', style: style);
        break;
      case 8:
        text = const Text('Salary', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
        child: text,
        axisSide: meta.axisSide,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta){
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 10,
      color: kGrey,
    );
    String text;
    switch (value.toInt()){
      case 1:
        text = '10k';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left,);
  }

  LineChartData mainData(){
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          )
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
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
          gradient: LinearGradient(
              colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
                colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ]
    );
  }

}
