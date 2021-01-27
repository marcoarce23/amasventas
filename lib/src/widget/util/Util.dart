import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:vector_math/vector_math_64.dart' as math;

//import 'package:amasventas/src/style/Style.dart' as style;

class RadialProgress extends StatefulWidget {
  final double goalCompleted;
  final Widget child;
  final Color progressColor;
  final Color progressBackgroundColor;
  final double width;

  const RadialProgress(
      {Key key,
      @required this.child,
      this.goalCompleted = 0.7,
      this.progressColor = Colors.white,
      this.progressBackgroundColor = Colors.white,
      this.width = 8})
      : super(key: key);

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
      });

    _radialProgressAnimationController.forward();
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.child,
      ),
      painter: RadialPainter(
        progressDegrees,
        widget.progressColor,
        widget.progressBackgroundColor,
        widget.width,
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees, width;
  final Color progressColor, progressBackgroundColor;

  RadialPainter(this.progressInDegrees, this.progressColor,
      this.progressBackgroundColor, this.width);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = progressBackgroundColor.withOpacity(0.5)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class GeneralWidget {
  GeneralWidget._();

  // Widget crearFondo(BuildContext context, String imagen) {
  //   final size = MediaQuery.of(context).size;

  //   final fondoModaro = Container(
  //     height: size.height * 0.40,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //       // begin: Alignment.topCenter,
  //       // end: Alignment.bottomRight,
  //       // stops: [1.0, 1.0, 1.0, 1.0],
  //       colors: [
  //         Color.fromRGBO(174, 214, 241, 1.0),
  //         Color.fromRGBO(174, 214, 241, 1.0),
  //         Color.fromRGBO(174, 214, 241, 1.0),
  //         Color.fromRGBO(174, 214, 241, 1.0),
  //       ],
  //     )),
  //   );

  //   return Stack(
  //     children: <Widget>[
  //       fondoModaro,
  //       ImageOpaqueNetworkCustomize(
  //           'http://res.cloudinary.com/propia/image/upload/v1592167496/djsbl74vjdwtso6zrst7.jpg',
  //           AppTheme.themeDefault,
  //           Size(MediaQuery.of(context).size.width, 310),
  //           0.68,
  //           BoxFit.cover),
  //       Container(
  //         padding: EdgeInsets.only(top: 32.0),
  //         child: Column(
  //           children: <Widget>[
  //             Align(
  //               child: RadialProgress(
  //                 width: 3,
  //                 goalCompleted: 0.90,
  //                 progressColor: AppTheme.themeDefault,
  //                 progressBackgroundColor: Colors.white,
  //                 child: Container(
  //                     child: ImageOvalNetwork(
  //                         imageNetworkUrl: imagen,
  //                         sizeImage: Size.fromWidth(90))),
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  boxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      stops: [0.1, 0.4, 0.7, 0.9],
      colors: [
        AppTheme.themeDefault,
        AppTheme.themeDefault,
        AppTheme.themeDefault,
        AppTheme.themeDefault,
      ],
    ));
  }

  boxDecorationAccesos() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          stops: [0.1, 0.4, 0.7],
          colors: [
            Color.fromRGBO(231, 233, 227, 0.6),
            Color.fromRGBO(225, 226, 223, 1.0),
            Color.fromRGBO(221, 221, 220, 0.6),
          ],
        ));
  }

  boxDecorationFondo() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            stops: [
              0.6,
              0.4,
              0.7
            ],
            colors: [
              Colors.white, Colors.white, Colors.white,
              // Color.fromRGBO(252, 252, 252, 1.0),
              //  Color.fromRGBO(251, 251, 251, 1.0),
            ]),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 7.0,
              offset: Offset(2.0, 3.0),
              spreadRadius: 4.0)
        ]);
  }

  boxDecorationList() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black12,
              blurRadius: 7.0,
              offset: Offset(2.0, 3.0),
              spreadRadius: 4.0)
        ]);
  }

  BoxDecoration contenedorCabecera() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 7.0,
              offset: Offset(2.0, 2.0),
              spreadRadius: 4.0)
        ]);
  }

  BoxDecoration contenedorCampos() {
    // return boxDecorationList();
    return BoxDecoration(
        color: Colors.white,
        // gradient: boxDecorationList(),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 7.0,
              offset: Offset(2.0, 3.0),
              spreadRadius: 4.0)
        ]);
  }

  BoxDecoration contenedorCarretes() {
    return BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 7.0,
              offset: Offset(2.0, 3.0),
              spreadRadius: 4.0)
        ]);
  }

  Container contenedorTitulo(
      BuildContext context, double height, String text, FaIcon icon) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.94,
      height: height,
      decoration: BoxDecoration(
          // color: AppTheme.themeDefault,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              stops: [
                0.1,
                0.4,
                0.7
              ],
              colors: [
                Color.fromRGBO(244, 245, 243, 1.0),
                Color.fromRGBO(247, 247, 247, 1.0),
                Color.fromRGBO(244, 245, 243, 1.0),
              ]),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 7.0,
                offset: Offset(2.0, 3.0),
                spreadRadius: 4.0)
          ]),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.0),
          icon,
          SizedBox(width: 15.0),
          Text(text,
              style: TextStyle(
                color: AppTheme.themeDefault, //Colors.white70,
                fontSize: 16.0,
                height: 1.5,
              )),
        ],
      ),
    );
  }

  Container contenedorSubTitulo(
      BuildContext context, double height, String text, FaIcon icon) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.92,
      height: height,
      decoration: BoxDecoration(
          color: AppTheme.themeDefault,
          //     gradient:LinearGradient(
          // begin: Alignment.topCenter,
          // end: Alignment.bottomRight,
          // stops: [0.1, 0.4, 0.7],
          // colors: [
          //   Color.fromRGBO(244, 245, 243, 1.0),
          //   Color.fromRGBO(247, 247, 247, 1.0),
          //    Color.fromRGBO(244, 245, 243, 1.0),

          //  ]),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 7.0,
                offset: Offset(2.0, 3.0),
                spreadRadius: 4.0)
          ]),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.0),
          icon,
          SizedBox(width: 15.0),
          Text(text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                height: 1.5,
              )),
        ],
      ),
    );
  }

  Widget fondoApp() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: boxDecorationFondo(), //(),//boxDecorationAccesos(),
    );
  }

  Divider divider() {
    return Divider(
      thickness: 1.5,
      color: AppTheme.themeDefault,
      endIndent: 20.0,
      indent: 20.0,
    );
  }

  SizedBox sizedBox(double ancho, double alto) {
    return SizedBox(
      width: ancho,
      height: alto,
    );
  }

  Widget messageText() {
    return Text(
      '(*) Campos obligatorios. ',
      style: kCamposTitleStyle,
      textAlign: TextAlign.left,
    );
  }
}
