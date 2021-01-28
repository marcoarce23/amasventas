import 'package:amasventas/src/data/entity/EntityFromJson/VentasGastosModel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnStack extends StatefulWidget {
  num ventas = 0;
  List<VentasGastosDetalleList> listaGasto =
      new List<VentasGastosDetalleList>();
  ColumnStack({this.ventas, this.listaGasto});

  @override
  _ColumnStackState createState() => _ColumnStackState();
}

class _ColumnStackState extends State<ColumnStack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getStackedColumnChart(),
    );
  }

  SfCartesianChart _getStackedColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 1,
      title: ChartTitle(text: 'Ingreso vs. Costos\n Expresado (Bs.)'),
      //legend: Legend(isVisible: true),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}',
          majorTickLines: MajorTickLines(size: 0)),
      series: _getStackedColumnSeries(),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'series.name',
          header: '',
          canShowMarker: false),
    );
  }

  /// Returns the list of chart serie which need to render
  /// on the stacked column chart.
  List<StackedColumnSeries<ChartDataColumnStack, String>>
      _getStackedColumnSeries() {
    final List<ChartDataColumnStack> chartData = <ChartDataColumnStack>[
      ChartDataColumnStack(
        serie: 'INGRESO',
        ventas: widget.ventas,
        gasto: 0,
        dptop1: 0,
        dptop2: 0,
        dptop3: 0,
        dptop4: 0,
      ),
      ChartDataColumnStack(
        serie: 'COSTOS',
        ventas: 0,
        gasto: 0,
        dptop1: num.parse(widget.listaGasto[0].mesEjecutado.toString()),
        dptop2: num.parse(widget.listaGasto[1].mesEjecutado.toString()),
        dptop3: num.parse(widget.listaGasto[2].mesEjecutado.toString()),
        dptop4: num.parse(widget.listaGasto[3].mesEjecutado.toString()),
        dptop5: num.parse(widget.listaGasto[4].mesEjecutado.toString()),
        dptop6: num.parse(widget.listaGasto[5].mesEjecutado.toString()),
        dptop7: num.parse(widget.listaGasto[6].mesEjecutado.toString()),
        dptop8: num.parse(widget.listaGasto[7].mesEjecutado.toString()),
        dptop9: num.parse(widget.listaGasto[8].mesEjecutado.toString()),
        dptop10: num.parse(widget.listaGasto[9].mesEjecutado.toString()),
        dptop11: num.parse(widget.listaGasto[10].mesEjecutado.toString()),
        dptop12: num.parse(widget.listaGasto[11].mesEjecutado.toString()),
        dptop13: num.parse(widget.listaGasto[12].mesEjecutado.toString()),
      ),
    ];

    return <StackedColumnSeries<ChartDataColumnStack, String>>[
      StackedColumnSeries<ChartDataColumnStack, String>(
          color: Colors.green,
          isVisibleInLegend: false,
          groupName: "ventas",
          dataLabelSettings: DataLabelSettings(
              color: Colors.blue,
              isVisible: true,
              showCumulativeValues: true,
              showZeroValue: false),
          dataSource: chartData,
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.ventas,
          name: 'Ingreso'),
      StackedColumnSeries<ChartDataColumnStack, String>(
          isVisibleInLegend: false,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              showCumulativeValues: true,
              showZeroValue: false),
          dataSource: chartData,
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.gasto,
          name: 'gasto'),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: true,
              showZeroValue: false),
          xAxisName: widget.listaGasto[0].detalle.toString(),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop1,
          name: widget.listaGasto[0].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          groupName: "gasto",
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop2,
          name: widget.listaGasto[1].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop3,
          name: widget.listaGasto[2].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop4,
          name: widget.listaGasto[3].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop5,
          name: widget.listaGasto[4].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop6,
          name: widget.listaGasto[5].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop7,
          name: widget.listaGasto[6].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop8,
          name: widget.listaGasto[7].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop9,
          name: widget.listaGasto[8].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop10,
          name: widget.listaGasto[9].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop11,
          name: widget.listaGasto[10].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop12,
          name: widget.listaGasto[11].detalle.toString()),
      StackedColumnSeries<ChartDataColumnStack, String>(
          dataSource: chartData,
          groupName: "gasto",
          dataLabelSettings: DataLabelSettings(
              color: Colors.red,
              isVisible: true,
              showCumulativeValues: false,
              showZeroValue: false),
          xValueMapper: (ChartDataColumnStack sales, _) => sales.serie,
          yValueMapper: (ChartDataColumnStack sales, _) => sales.dptop13,
          name: widget.listaGasto[12].detalle.toString()),
    ];
  }
}

class ChartDataColumnStack {
  /// Holds the datapoint values like x, y, etc.,
  ChartDataColumnStack({
    this.ventas,
    this.gasto,
    this.name,
    this.serie,
    this.dptop1,
    this.dptop2,
    this.dptop3,
    this.dptop4,
    this.dptop5,
    this.dptop6,
    this.dptop7,
    this.dptop8,
    this.dptop9,
    this.dptop10,
    this.dptop11,
    this.dptop12,
    this.dptop13,
  });

  /// Holds x value of the datapoint
  String serie;
  String name;

  num ventas;
  num gasto;

  /// Holds y value of the datapoint
  num dptop1;
  num dptop2;
  num dptop3;
  num dptop4;
  num dptop5;
  num dptop6;
  num dptop7;
  num dptop8;
  num dptop9;
  num dptop10;
  num dptop11;
  num dptop12;
  num dptop13;
  num dptop14;
  num dptop15;
}
