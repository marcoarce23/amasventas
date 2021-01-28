import 'package:amasventas/src/page/ventas/ResultadoKpiPage.dart';
import 'package:amasventas/src/widget/Dashboard/AreaChart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';

class VentasAllPage extends StatefulWidget {
  static final String routeName = 'ventasAll';
  const VentasAllPage({Key key}) : super(key: key);

  @override
  _VentasAllPageState createState() => _VentasAllPageState();
}

class _VentasAllPageState extends State<VentasAllPage> {
  int page = 1;
  final prefs = new Preferense();
  final List<Widget> optionPage = [
    HomePage(),
    VentasPage(),
    ResultadoKPIPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = VentasAllPage.routeName;
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
              title: Text('Mis Ventas')),
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

class VentasPage extends StatefulWidget {
  static final String routeName = 'ventas';

  @override
  _VentasPageState createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
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
