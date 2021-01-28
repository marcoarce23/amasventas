
import 'package:amasventas/src/widget/Dashboard/LineChart.dart';
import 'package:flutter/material.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';

class ResultadoKPIPage extends StatefulWidget {
  static final String routeName = 'resultadoKPI';

  @override
  _ResultadoKPIPageState createState() => _ResultadoKPIPageState();
}

class _ResultadoKPIPageState extends State<ResultadoKPIPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = new Preferense();

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('INFORMACIÓN KPI'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
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
              sizedBox(0.0, 8.0),
              showInformationBasic(
                context,
                'Bienvenido Gustavo Zalles!!',
                'Progreso de ventas: 5000.00 Bs',
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
                        Text('Objetivo del MEs:'),
                        Text('3455 Bs.'),
                      ],
                    ),
                    LineChart(),
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
                    Text('Visualziación del Histórico de tus KPIs:'),
                    Text('Promedio 60%.'),
                    Text('El resultado: Aceptable'),
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
