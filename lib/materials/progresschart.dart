import 'package:flutter/material.dart';
import 'package:salessystem/materials/chart_painter.dart';

class Score {
  double value;
  DateTime time;
  Score(this.value, this.time);
}

class ProgressChart extends StatefulWidget {
  // ProgressChart({Key key}) : super(key: key);

  final List<Score> scores;
  ProgressChart(this.scores);

  @override
  _ProgressChartState createState() => _ProgressChartState();
}

const day = ["", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

class _ProgressChartState extends State<ProgressChart> {
  double _min, _max;
  List<double> _Y;
  List<String> _X;
  @override
  void initState() {
    super.initState();
    var min = double.maxFinite;
    var max = -double.maxFinite;
    widget.scores.forEach((p) {
      min = min > p.value ? p.value : min;
      max = max < p.value ? p.value : max;
    });

    setState(() {
      _min = min;
      _max = max;
      _Y = widget.scores.map((p) => p.value).toList();
      _X = widget.scores
          .map((p) => "${day[p.time.weekday]}\n${p.time.day}")
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Container(),
        painter: ChartPainter(_X, _Y, _min, _max),
      ),
    );
  }
}
