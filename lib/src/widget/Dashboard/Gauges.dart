/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

// ignore: must_be_immutable
class GaugeColor extends StatefulWidget {
  @override
  _GaugeColorState createState() => _GaugeColorState();
  String textoInterior;
  String colorAguja;
  String textoInferior;
  double valor;
  double venta;
  String moneda;

  GaugeColor(
      {this.textoInterior,
      this.colorAguja,
      this.textoInferior,
      this.valor,
      this.venta,
      this.moneda});
}

class _GaugeColorState extends State<GaugeColor> {
  double _interval = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getGauge(),
    );
  }

  SfRadialGauge _getGauge() {
    return SfRadialGauge(
      animationDuration: 5500,
      enableLoadingAnimation: true,
      title: GaugeTitle(
          text: 'CUMPLIMIENTO DE TUS METAS',
          borderColor: Colors.black,
          backgroundColor: Colors.blueGrey,
          textStyle: TextStyle(color: Colors.white, fontSize: 16,)),
      axes: <RadialAxis>[
        RadialAxis(
            startAngle: 130,
            endAngle: 50,
            minimum: 0,
            maximum: 110,
            interval: _interval,
            minorTicksPerInterval: 9,
            showAxisLine: true,
            radiusFactor: 0.9,
            labelOffset: 8,
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: 0,
                  endValue: 50,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(255, 44, 12, 1)),
              GaugeRange(
                  startValue: 50,
                  endValue: 80,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(230, 224, 24, 0.9)),
              GaugeRange(
                  startValue: 80,
                  endValue: 100,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(0, 194, 16, 0.76)),
              GaugeRange(
                  startValue: 100,
                  endValue: 120,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(18, 0, 230, 0.9)),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.35,
                  widget: Container(
                      child: Text(widget.textoInterior,
                          style: TextStyle(
                              color: Color(0xFFF8B195), fontSize: 25)))),
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.8,
                  widget: Container(
                    child: Text(
                      widget.textoInferior,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ))
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: widget.valor,
                needleLength: 0.6,
                lengthUnit: GaugeSizeUnit.factor,
                needleStartWidth: 1,
                needleEndWidth: 8,
                animationType: AnimationType.easeOutBack,
                enableAnimation: true,
                animationDuration: 1200,
                knobStyle: KnobStyle(
                    knobRadius: 0.09,
                    sizeUnit: GaugeSizeUnit.factor,
                    borderColor: Colors.black,
                    color: Colors.white,
                    borderWidth: 0.05),
                tailStyle: TailStyle(
                    color: Colors.black,
                    width: 8,
                    lengthUnit: GaugeSizeUnit.factor,
                    length: 0.2),
                needleColor: Colors.black,
              )
            ],
            axisLabelStyle: GaugeTextStyle(fontSize: 15),
            majorTickStyle: MajorTickStyle(
                length: 0.25, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
            minorTickStyle: MinorTickStyle(
                length: 0.13, lengthUnit: GaugeSizeUnit.factor, thickness: 1))
      ],
    );
  }

  // SfRadialGauge getRadialTextPointer() {
  //   return SfRadialGauge(
  //     axes: <RadialAxis>[
  //       RadialAxis(
  //           showAxisLine: false,
  //           showLabels: false,
  //           showTicks: false,
  //           startAngle: 180,
  //           endAngle: 360,
  //           minimum: 0,
  //           maximum: 120,
  //           canScaleToFit: true,
  //           radiusFactor: 0.79,
  //           pointers: <GaugePointer>[
  //             NeedlePointer(
  //                 needleStartWidth: 1,
  //                 lengthUnit: GaugeSizeUnit.factor,
  //                 needleEndWidth: 5,
  //                 needleLength: 0.7,
  //                 value: 82,
  //                 knobStyle: KnobStyle(knobRadius: 0)),
  //           ],
  //           ranges: <GaugeRange>[
  //             GaugeRange(
  //                 startValue: 0,
  //                 endValue: 20,
  //                 startWidth: 0.45,
  //                 endWidth: 0.45,
  //                 sizeUnit: GaugeSizeUnit.factor,
  //                 color: const Color(0xFFDD3800)),
  //             GaugeRange(
  //                 startValue: 20.5,
  //                 endValue: 40,
  //                 startWidth: 0.45,
  //                 sizeUnit: GaugeSizeUnit.factor,
  //                 endWidth: 0.45,
  //                 color: const Color(0xFFFF4100)),
  //             GaugeRange(
  //                 startValue: 40.5,
  //                 endValue: 60,
  //                 startWidth: 0.45,
  //                 sizeUnit: GaugeSizeUnit.factor,
  //                 endWidth: 0.45,
  //                 color: const Color(0xFFFFBA00)),
  //             GaugeRange(
  //                 startValue: 60.5,
  //                 endValue: 80,
  //                 startWidth: 0.45,
  //                 sizeUnit: GaugeSizeUnit.factor,
  //                 endWidth: 0.45,
  //                 color: const Color(0xFFFFDF10)),
  //             GaugeRange(
  //                 startValue: 80.5,
  //                 endValue: 100,
  //                 sizeUnit: GaugeSizeUnit.factor,
  //                 startWidth: 0.45,
  //                 endWidth: 0.45,
  //                 color: const Color(0xFF8BE724)),
  //             GaugeRange(
  //                 startValue: 100.5,
  //                 endValue: 120,
  //                 startWidth: 0.45,
  //                 endWidth: 0.45,
  //                 sizeUnit: GaugeSizeUnit.factor,
  //                 color: const Color(0xFF64BE00)),
  //           ]),
  //       RadialAxis(
  //         showAxisLine: false,
  //         showLabels: false,
  //         showTicks: false,
  //         startAngle: 180,
  //         endAngle: 360,
  //         minimum: 0,
  //         maximum: 120,
  //         radiusFactor: 0.85,
  //         canScaleToFit: true,
  //         pointers: <GaugePointer>[
  //           MarkerPointer(
  //               markerType: MarkerType.text,
  //               text: 'Poor',
  //               value: 20.5,
  //               textStyle: GaugeTextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   //  fontSize: isCardView ? 14 : 18,
  //                   fontSize: 14,
  //                   fontFamily: 'Times'),
  //               offsetUnit: GaugeSizeUnit.factor,
  //               markerOffset: -0.12),
  //           MarkerPointer(
  //               markerType: MarkerType.text,
  //               text: 'Atención',
  //               value: 60.5,
  //               textStyle: GaugeTextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 14,
  //                   fontFamily: 'Times'),
  //               offsetUnit: GaugeSizeUnit.factor,
  //               markerOffset: -0.12),
  //           MarkerPointer(
  //               markerType: MarkerType.text,
  //               text: 'Aceptable',
  //               value: 100.5,
  //               textStyle: GaugeTextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 14,
  //                   fontFamily: 'Times'),
  //               offsetUnit: GaugeSizeUnit.factor,
  //               markerOffset: -0.12)
  //         ],
  //       ),
  //     ],
  //   );
}
