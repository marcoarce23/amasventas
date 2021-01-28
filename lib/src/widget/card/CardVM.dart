import 'package:amasventas/src/theme/Theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CardVM extends StatelessWidget {
  final String imageAssets;
  final List<Widget> listWidgets;
  final Widget opciones;
  final List<Widget> accesosRapidos;
  final double size;
  const CardVM(
      {this.imageAssets,
      this.listWidgets,
      this.opciones,
      this.accesosRapidos,
      this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(0.5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                height: size,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      //Color.fromRGBO(123, 68, 242, 95),
                      AppTheme.themeGreen,
                      Colors.black
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: CustomPaint(
                  size: Size(size - 50, size),
                  painter: CustomShape(
                      10, Colors.white,  AppTheme.themeGreen,),
                ),
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      imageAssets,
                      width: 50,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SlideInUp(
                  duration: Duration(seconds: 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: listWidgets,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            (opciones == null) ? Container() : opciones
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SlideInUp(
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: (accesosRapidos == null)
                          ? [Container()]
                          : accesosRapidos,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomShape extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomShape(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, 10)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height - 10)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
