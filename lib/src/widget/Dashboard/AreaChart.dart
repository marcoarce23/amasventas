import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AreaChart extends StatefulWidget {
  AreaChart({Key key}) : super(key: key);

  @override
  _AreaChartState createState() => _AreaChartState();
}

class _AreaChartState extends State<AreaChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getDefaultAreaChart(),
    );
  }

  SfCartesianChart _getDefaultAreaChart() {
    return SfCartesianChart(
      legend: Legend(isVisible: false, opacity: 0.7),
      title: ChartTitle(text: 'Bono -Porcentaje de cumplimiento'),
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.y(),
          interval: 1,
          intervalType: DateTimeIntervalType.years,
          majorGridLines: MajorGridLines(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}M',
          title: AxisTitle(text: 'Expresado en dólares'),
          interval: 1,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: _getDefaultAreaSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of Chart series
  /// which need to render on the default area chart.
  List<AreaSeries<ChartSampleDataArea, DateTime>> _getDefaultAreaSeries() {
    final List<ChartSampleDataArea> chartData = <ChartSampleDataArea>[
      ChartSampleDataArea(
        x: DateTime(2000, 1, 1),
        y: 4,
      ),
      ChartSampleDataArea(
        x: DateTime(2001, 1, 1),
        y: 3.0,
      ),
      ChartSampleDataArea(
        x: DateTime(2002, 1, 1),
        y: 3.8,
      ),
      ChartSampleDataArea(
        x: DateTime(2003, 1, 1),
        y: 3.4,
      ),
      ChartSampleDataArea(
        x: DateTime(2004, 1, 1),
        y: 3.2,
      ),
      ChartSampleDataArea(
        x: DateTime(2005, 1, 1),
        y: 3.9,
      ),
    ];
    return <AreaSeries<ChartSampleDataArea, DateTime>>[
      AreaSeries<ChartSampleDataArea, DateTime>(
        dataSource: chartData,
        opacity: 0.7,
        name: 'Product A',
        xValueMapper: (ChartSampleDataArea sales, _) => sales.x,
        yValueMapper: (ChartSampleDataArea sales, _) => sales.y,
      ),
    ];
  }
}

///Chart sample data
class ChartSampleDataArea {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleDataArea({
    this.x,
    this.y,
    this.xValue,
    this.yValue,
  });

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num yValue;
}
