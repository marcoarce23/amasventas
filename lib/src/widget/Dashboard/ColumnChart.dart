import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatefulWidget {
  ColumnChart({Key key}) : super(key: key);

  @override
  _ColumnChartState createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getTrackerColumnChart(),
    );
  }

  SfCartesianChart _getTrackerColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Marks of a student'),
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 10000,
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: _getTracker(),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          canShowMarker: false,
          header: '',
          format: 'point.y marks in point.x'),
    );
  }

  /// Get column series with tracker
  List<ColumnSeries<ChartSampleDataColumn, String>> _getTracker() {
    final List<ChartSampleDataColumn> chartData = <ChartSampleDataColumn>[
      ChartSampleDataColumn(x: '1', y: 7100),
      ChartSampleDataColumn(x: '2', y: 840),
      ChartSampleDataColumn(x: '3', y: 480),
      ChartSampleDataColumn(x: '4', y: 8000),
      ChartSampleDataColumn(x: '5', y: 360),
      ChartSampleDataColumn(x: '6', y: 750),
      ChartSampleDataColumn(x: '7', y: 5300),
      ChartSampleDataColumn(x: '8', y: 830),
      ChartSampleDataColumn(x: '9', y: 280),
      ChartSampleDataColumn(x: '10', y: 180),
      ChartSampleDataColumn(x: '11', y: 320),
      ChartSampleDataColumn(x: '12', y: 5660),
    ];
    return <ColumnSeries<ChartSampleDataColumn, String>>[
      ColumnSeries<ChartSampleDataColumn, String>(
          dataSource: chartData,

          /// We can enable the track for column here.
          isTrackVisible: true,
          trackColor: const Color.fromRGBO(198, 201, 207, 1),
          borderRadius: BorderRadius.circular(15),
          xValueMapper: (ChartSampleDataColumn sales, _) => sales.x,
          yValueMapper: (ChartSampleDataColumn sales, _) => sales.y,
          name: 'Marks',
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.top,
              textStyle: const TextStyle(fontSize: 10, color: Colors.white)))
    ];
  }
}

class ChartSampleDataColumn {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleDataColumn({
    this.x,
    this.y,
  });

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num y;
}
