import 'dart:io';
import 'dart:ui';
import 'package:amasventas/src/page/home/Menu.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:amasventas/src/widget/drawer/FloatMenuWidget.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:flutter/material.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = new Preferense();
  File photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      appBar: appBar('AMASZONAS DIGITAL'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          // _fondoApp(),
          SingleChildScrollView(
            child: Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/portada1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  sizedBox(0.0, 5),
                  showInformationBasic(
                    context,
                    'Bienvenido a Amaszonas - ${prefs.nameUser.toString().toUpperCase()}. ',
                    'Vive la nueva experiencia en tu celular',
                  ),
                  sizedBox(0.0, 6),
                  dividerGreen(),
                  sizedBox(0.0, 10),
                  // ColumnInside(),
                  // ColumnCompare(),
                  _botonesRedondeados(),
                  copyRigthBlack(),
                  //   LineChart(),
                ],
              ),
            ),
          )
        ],
      ),
      //    bottomNavigationBar: BottonNavigation(),
      floatingActionButton: boomMenu(context),
    );
  }

  Widget _botonesRedondeados() {
    return Table(children: [
      TableRow(children: [
        _crearBotonRedondeado(
            Colors.blue, Icons.payment, 'Amasventas', MenuPage(opt: 'AMV')),
        _crearBotonRedondeado(Colors.purpleAccent, Icons.flight_takeoff,
            'AmasPerformance', MenuPage(opt: 'AMP')),
      ]),
      // TableRow(children: [
      //   _crearBotonRedondeado(
      //       Colors.pinkAccent, Icons.shop, 'Amascompras', MenuPage()),
      //   _crearBotonRedondeado(
      //       Colors.orange, Icons.insert_drive_file, 'Amasventas', MenuPage()),
      // ]),
      // TableRow(children: [
      //   _crearBotonRedondeado(
      //       Colors.blueAccent, Icons.movie_filter, 'Amasventas', MenuPage()),
      //   _crearBotonRedondeado(
      //       Colors.green, Icons.cloud, 'Amasventas', MenuPage()),
      // ]),
    ]);
  }

  Widget _crearBotonRedondeado(
      Color color, IconData icono, String texto, Widget widget) {
    return InkWell(
      onTap: () {
        navegation(context, widget);
      },
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 100.0,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white, //Color.fromRGBO(62, 66, 107, 0.7),
              borderRadius: BorderRadius.circular(25.0),

              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 1.0,
                    offset: Offset(1.0, 2.0),
                    spreadRadius: 1.5)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5.0),
                CircleAvatar(
                  backgroundColor: color,
                  radius: 35.0,
                  child: Icon(icono, color: Colors.white, size: 40.0),
                ),
                Text(texto, style: TextStyle(color: color)),
                SizedBox(height: 5.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
