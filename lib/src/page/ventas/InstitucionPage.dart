import 'package:amasventas/src/widget/Dashboard/AreaChart.dart';
import 'package:flutter/material.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';

class InstitutionPage extends StatefulWidget {
  static final String routeName = 'ventas';

  @override
  _InstitutionPageState createState() => _InstitutionPageState();
}

class _InstitutionPageState extends State<InstitutionPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = new Preferense();

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
//sssss
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('MIS RESULTADOS XXXX'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          // Container(
          //     width: size.width * 0.94,
          //     decoration: containerFileds(),
          //     //   child: _fields(context),
          //   child: Column(children: [
         // RadialBarAngle(titulo: 'Institucion'),
          //  ])),
          //  _form(context),
        ],
      ),
      // floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
      //     FaIcon(FontAwesomeIcons.futbol), HomePage()),
    );
  }

  Widget _form(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          //  color: Colors.black87,

          child: Column(
            children: <Widget>[
              //
              sizedBox(0.0, 8.0),

              showInformationBasic(
                context,
                'Bienvenido Gustavo Zalles!!',
                'REPORTE DE VENTAS',
              ),
              sizedBox(0.0, 8.0),

              Container(
                width: size.width * 0.94,
                decoration: containerFileds(),
                //   child: _fields(context),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('TOTAL COMISION VENTAS:'),
                        Text('2500.00 Sus.'),
                      ],
                    ),
                    AreaChart(),
                  ],
                ),
              ),
              sizedBox(0.0, 8.0),

              copyRigthBlack(),
            ],
          ),
        ),
      ),
    );
  }
}

class VentasDetallePage extends StatefulWidget {
  static final String routeName = 'ventas';

  @override
  _VentasDetallePageState createState() => _VentasDetallePageState();
}

class _VentasDetallePageState extends State<VentasDetallePage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = new Preferense();

  @override
  void initState() {
    super.initState();
  }

//sssss
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('MIS VENTAS DETALLE'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          //  showPictureOval(photo, image, 130.0),
          _form(context),
        ],
      ),
      // floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
      //     FaIcon(FontAwesomeIcons.futbol), HomePage()),
    );
  }

  Widget _form(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          //  color: Colors.black87,

          child: Column(
            children: <Widget>[
              //
              sizedBox(0.0, 8.0),

              showInformationBasic(
                context,
                'Bienvenido Gustavo Zalles!!',
                'REPORTE DE VENTAS',
              ),
              sizedBox(0.0, 8.0),

              Container(
                width: size.width * 0.94,
                decoration: containerFileds(),
                //   child: _fields(context),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('TOTAL COMISION VENTAS:'),
                        Text('2500.00 Sus.'),
                      ],
                    ),
                    AreaChart(),
                  ],
                ),
              ),
              sizedBox(0.0, 8.0),

              Container(
                width: size.width * 0.94,
                decoration: containerFileds(),
                //   child: _fields(context),
                child: Column(
                  children: [
                    Text('Escala: ESCALA BASICA FIJA CTO.'),
                    Text('Tipo: ESCALA MONTO FINO'),
                    Text('Counter: Gustavo Zalles'),
                  ],
                ),
              ),
              sizedBox(0.0, 8.0),

              copyRigthBlack(),
            ],
          ),
        ),
      ),
    );
  }
}
