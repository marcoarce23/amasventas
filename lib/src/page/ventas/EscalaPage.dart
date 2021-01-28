import 'package:amasventas/src/widget/Dashboard/AreaChart.dart';
import 'package:amasventas/src/widget/Dashboard/Gauges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';

class EscalaAllPage extends StatefulWidget {
  static final String routeName = 'escalaAll';
  const EscalaAllPage({Key key}) : super(key: key);

  @override
  _EscalaAllPageState createState() => _EscalaAllPageState();
}

class _EscalaAllPageState extends State<EscalaAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [EscalaPage(), EscalaDetallePage()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = EscalaAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 21.0,
        backgroundColor: AppTheme.themeDefault,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.bell,
                size: 25,
              ),
              title: Text('Mis Escalas')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.listAlt,
                size: 25,
              ),
              title: Text('Detalle')),
        ],
        currentIndex: page,
        unselectedItemColor: AppTheme.themeWhite,
        selectedItemColor: AppTheme.themeRed,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
      //),
    );
  }
}

class EscalaPage extends StatefulWidget {
  static final String routeName = 'escala';

  @override
  _EscalaPageState createState() => _EscalaPageState();
}

class _EscalaPageState extends State<EscalaPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final prefs = new Preferense();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('ESCALA'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          //  showPictureOval(photo, image, 130.0),
          _form(context),
        ],
      ),
      floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.futbol), HomePage()),
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
                'ESCALA DE BONO',
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

class EscalaDetallePage extends StatefulWidget {
  static final String routeName = 'escala';

  @override
  _EscalaDetallePageState createState() => _EscalaDetallePageState();
}

class _EscalaDetallePageState extends State<EscalaDetallePage> {
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
      appBar: appBar('ESCALA DETALLA'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          //  showPictureOval(photo, image, 130.0),
          _form(context),
        ],
      ),
      floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.futbol), HomePage()),
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
                'Estos son tus resultados. La familia Amaszonas valora tu esfuerzo!!!',
              ),
              sizedBox(0.0, 5.0),

              showInformationBasic(
                context,
                'Progreso de ventas: 5000.00 Bs.',
                'Estos son tus resultados. La familia Amaszonas valora tu esfuerzo!!!',
              ),
              Container(
                width: size.width * 0.94,
                height: 250,
                //   // margin: EdgeInsets.symmetric(vertical: 0.0),
                decoration: containerFileds(),
                //   child: _fields(context),
                child: GaugeColor(),
              ),
              copyRigthBlack(),
            ],
          ),
        ),
      ),
    );
  }
}
