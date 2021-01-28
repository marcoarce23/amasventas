import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnInside extends StatefulWidget {
  @override
  _ColumnInsideState createState() => _ColumnInsideState();
  String labelVentas = 'Ingreso';
  String labelPagos = 'Costo';
  String titulo = "TITULO EN BLANCO";
  List<ChartSampleDataColumnInside> chartData =
      List<ChartSampleDataColumnInside>();

  ColumnInside(
      {this.labelVentas, this.labelPagos, this.chartData, this.titulo});
}

class _ColumnInsideState extends State<ColumnInside> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 450, child: _getBackColumnChart());
  }

  SfCartesianChart _getBackColumnChart() {
    return SfCartesianChart(
        enableAxisAnimation: true,
        plotAreaBorderWidth: 0,
        enableSideBySideSeriesPlacement: false,
        legend: Legend(
            position: LegendPosition.bottom,
            isVisible: true,
            // Overflowing legend content will be wraped
            overflowMode: LegendItemOverflowMode.wrap),
        title: ChartTitle(
            text: widget.titulo,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        primaryXAxis: CategoryAxis(
          labelRotation: 270,
          labelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 10,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
            minimum: 0,
            majorTickLines: MajorTickLines(size: 0),
            numberFormat: NumberFormat.compactLong(locale: 'es_ES'),
            majorGridLines: MajorGridLines(width: 0),
            rangePadding: ChartRangePadding.additional),
        series: _getBackToBackColumn(),
        tooltipBehavior: TooltipBehavior(enable: true));
  }

  List<ColumnSeries<ChartSampleDataColumnInside, String>>
      _getBackToBackColumn() {
    return <ColumnSeries<ChartSampleDataColumnInside, String>>[
      ColumnSeries<ChartSampleDataColumnInside, String>(
          dataSource: widget.chartData,
          width: 0.7,
          xValueMapper: (ChartSampleDataColumnInside sales, _) => sales.x,
          yValueMapper: (ChartSampleDataColumnInside sales, _) => sales.yValue,
          name: 'Programado'),
      ColumnSeries<ChartSampleDataColumnInside, String>(
          dataSource: widget.chartData,
          width: 0.3,
          xValueMapper: (ChartSampleDataColumnInside sales, _) => sales.x,
          yValueMapper: (ChartSampleDataColumnInside sales, _) => sales.y,
          name: 'Ejecutado')
    ];
  }
}

class ChartSampleDataColumnInside {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleDataColumnInside({this.x, this.y, this.yValue});

  /// Holds x value of the datapoint
  String x;

  /// Holds y value of the datapoint
  num y;
  num yValue;
}
