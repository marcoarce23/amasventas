import 'package:amasventas/src/widget/Dashboard/Gauges.dart';
import 'package:amasventas/src/widget/Dashboard/LineChart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';

class BonoAllPage extends StatefulWidget {
  static final String routeName = 'resultadoAll';
  const BonoAllPage({Key key}) : super(key: key);

  @override
  _BonoAllPageState createState() => _BonoAllPageState();
}

class _BonoAllPageState extends State<BonoAllPage> {
  int page = 1;
  final prefs = new Preferense();
  final List<Widget> optionPage = [HomePage(), BonoPage(), BonoDetallePage()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = BonoAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 21.0,
        backgroundColor: AppTheme.themeGreen,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.home,
                size: 25,
              ),
              title: Text('Inicio')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.moneyBill,
                size: 25,
              ),
              title: Text('Mis Bonos')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.listAlt,
                size: 25,
              ),
              title: Text('Detalle')),
        ],
        currentIndex: page,
        unselectedItemColor: AppTheme.themeDefault,
        selectedItemColor: AppTheme.themeWhite,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
      //),
    );
  }
}

class BonoPage extends StatefulWidget {
  static final String routeName = 'bono';

  @override
  _ResultadoPageState createState() => _ResultadoPageState();
}

class _ResultadoPageState extends State<BonoPage> {
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
      appBar: appBar('MIS RESULTADOS'),
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
                        Text('REPORTE HISTORICO DE BONO'),
                  
                      ],
                    ),
                    GaugeColor(),
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
                    Text('Tu bono Cump. PPTo.:'),
                    Text('400.00 SuS.'),
                    Text('El resultado: Atención'),
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

class BonoDetallePage extends StatefulWidget {
  static final String routeName = 'bono';

  @override
  _BonoDetallePageState createState() => _BonoDetallePageState();
}

class _BonoDetallePageState extends State<BonoDetallePage> {
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
      appBar: appBar('REPORTE DE BONO'),
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
                'Reporte de Cumplimiento KPI+Bono de Venta',
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
                       Text('REPORTE HISTORICO DE BONO'),
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
                    Text('Reporte de Cumplimiento KPI + Bono de Venta:'),
                    Text('Promedio de Bono XX%.'),
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
