import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnCompare extends StatefulWidget {
  @override
  _ColumnCompareState createState() => _ColumnCompareState();

  String labelVentas = 'Presupuesto';
  String labelPagos = 'Gastos';
  double doubleVentas = 0;
  double doublePagos = 0;
  String titulo = "TITULO EN BLANCO";

  ColumnCompare(
      {this.labelVentas,
      this.labelPagos,
      this.doublePagos,
      this.doubleVentas,
      this.titulo});
}

class _ColumnCompareState extends State<ColumnCompare> {
  //ignore: unused_field

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getColumChart(),
    );
  }

  /// Returns the spline chart with axis crossing at provided axis value.
  SfCartesianChart _getColumChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: widget.titulo,
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelIntersectAction: AxisLabelIntersectAction.wrap,
          crossesAt: 0,
          placeLabelsNearAxisLine: false),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          minimum: 0,
          maximum: widget.doubleVentas,
          majorTickLines: MajorTickLines(size: 0)),
      series: _getSeries(),
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }

  /// Returns the list of chart series which need to render on
  /// the bar or column chart with axis crossing.

  List<ChartSeries<ChartSampleDataColumnCompare, String>> _getSeries() {
    List<ChartSeries<ChartSampleDataColumnCompare, String>> chart = null;
    final List<ChartSampleDataColumnCompare> chartData =
        <ChartSampleDataColumnCompare>[
      ChartSampleDataColumnCompare(
          x: widget.labelVentas,
          y: num.parse(widget.doubleVentas.toString()),
          pointColor: Color.fromRGBO(107, 189, 98, 1)),
      ChartSampleDataColumnCompare(
          x: widget.labelPagos,
          y: num.parse(widget.doublePagos.toString()),
          pointColor: Color.fromRGBO(199, 86, 86, 1))
    ];
    chart = <ChartSeries<ChartSampleDataColumnCompare, String>>[
      ColumnSeries<ChartSampleDataColumnCompare, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleDataColumnCompare sales, _) => sales.x,
          yValueMapper: (ChartSampleDataColumnCompare sales, _) => sales.y,
          pointColorMapper: (ChartSampleDataColumnCompare sales, _) =>
              sales.pointColor,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.middle,
              alignment: ChartAlignment.center)),
    ];
    return chart;
  }
}

class ChartSampleDataColumnCompare {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleDataColumnCompare({
    this.x,
    this.y,
    this.pointColor,
  });

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num y;

  final Color pointColor;
}
