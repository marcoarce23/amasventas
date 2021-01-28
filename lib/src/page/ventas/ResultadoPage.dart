import 'dart:io';
import 'package:amasventas/src/data/entity/EntityFromJson/RendimientoModel.dart';
import 'package:amasventas/src/page/home/Menu.dart';
import 'package:amasventas/src/page/ventas/ResultadoKpiPage.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:amasventas/src/widget/Dashboard/ChartLine.dart';
import 'package:amasventas/src/widget/Dashboard/Gauges.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:shimmer/shimmer.dart';

class ResultadoAllPage extends StatefulWidget {
  static final String routeName = 'resultadoAll';
  const ResultadoAllPage({Key key}) : super(key: key);

  @override
  _ResultadoAllPageState createState() => _ResultadoAllPageState();
}

class _ResultadoAllPageState extends State<ResultadoAllPage> {
  int page = 1;
  final prefs = new Preferense();
  final List<Widget> optionPage = [
    HomePage(),
    ResultadoPage(),
    ResultadoKPIPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = ResultadoAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 45.0,
        backgroundColor: Colors.white70,
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
              title: Text('Mis Resultados')),
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

class ResultadoPage extends StatefulWidget {
  static final String routeName = 'resultados';

  @override
  _ResultadoPageState createState() => _ResultadoPageState();
}

class _ResultadoPageState extends State<ResultadoPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  RendimientoList entity = new RendimientoList();
  RendimientoKPIList entityKPI = new RendimientoKPIList();
  RendimientoDetalleList entityDetalle = new RendimientoDetalleList();
  Repository repo = new Repository();
  final prefs = new Preferense();

  //DEFINICION DE VARIABLES
  File photo;
  String totalComision = "0";
  String comisionKPI = "0";
  String porcentajeKPI = "0";
  String nombreCompleto = "";
  String moneda = "SUS";
  double ponderacionKPI = 0;
  var size;

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

//sssss
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('MIS RENDIMIENTOS'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          _form(context),
        ],
      ),
      floatingActionButton: floatButton(AppTheme.themeGreen, context,
          FaIcon(FontAwesomeIcons.arrowLeft), MenuPage(opt: 'AMP')),
    );
  }

  Widget _form(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _header(),
            sizedBox(0.0, 6.0),
            dividerGreen(),
            _futureBuilderGauge(context),
            dividerGreen(),
            sizedBox(0.0, 13.0),
            _futureBuilderKPI(context),
            accordionWidget(
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.chartLine, color: Colors.white),
                    sizedBox(10.0, 0.0),
                    Text("VER DETALLE KPI",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                _detallePerformanceKPI(context),
                Colors.blueGrey,
                Colors.blueGrey,
                true),
            _futureBuilderList(context),
            copyRigthBlack(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 5.0),
          Column(
            children: [
              Row(
                children: [
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.clock, color: Colors.green),
                  sizedBox(8, 0.0),
                  Text('Fecha actual : '.toUpperCase(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Text('${DateTime.now().toString().substring(0, 10)}',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.user, color: Colors.green),
                  sizedBox(8, 0.0),
                  Text('Bienvenido       :'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Text(prefs.nameUser.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detallePerformanceKPI(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width * 0.98,
          decoration: containerFileds1(Colors.blue),
          child: Column(
            children: [
              sizedBox(0, 10.0),
              Row(
                children: [
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.commentDollar, color: Colors.white),
                  sizedBox(8, 0.0),
                  Text('TU BONO PERFORMANCE KPI'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              sizedBox(0, 10.0),
            ],
          ),
        ),
        sizedBox(0, 10.0),
        Container(
            width: size.width * 0.98,
            decoration: containerFileds1(Colors.white),
            child: Column(
              children: [
                sizedBox(0, 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sizedBox(15, 2.0),
                    Text('$comisionKPI $moneda',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                sizedBox(0, 10.0),
              ],
            )),
        sizedBox(0, 10.0),
        Container(
          width: size.width * 0.98,
          decoration: containerFileds1(Colors.green),
          child: Column(
            children: [
              sizedBox(0, 15.0),
              Row(
                children: [
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.handHoldingUsd, color: Colors.white),
                  sizedBox(8, 0.0),
                  Text('TOTAL BONO: '.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  Text('$totalComision  $moneda',
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              sizedBox(0, 10.0),
            ],
          ),
        ),
      ],
    );
  }

//# inicio del Gauge
  Widget _futureBuilderGauge(BuildContext context) {
    entity.apiUrl =
        "http://amasventas.neuronatexnology.com/api/GetIndicadores/GetVentasMesIndicador/durioste";
    return FutureBuilder(
        future: new Repository().getData(entity),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listViewGauge(context, snapshot);
          }
        });
  }

  Widget _futureBuilderKPI(BuildContext context) {
    entityKPI.apiUrl =
        "http://amasventas.neuronatexnology.com/api/GetIndicadores/GetVentasMesKPI/DUrioste";
    return FutureBuilder(
        future: new Repository().getData(entity),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return _listViewKPI(context, snapshot);
          }
        });
  }

  Widget _listViewKPI(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        RendimientoList entity = snapshot.data[index];

        return accordionWidget(
            Row(
              children: [
                FaIcon(FontAwesomeIcons.star,
                    color: Colors.yellow, semanticLabel: '5', size: 45),
                Text("tu performance kpi".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            _showListDetail(entity, context),
            Colors.blueGrey,
            Colors.blueGrey,
            true);
      },
    );
  }

  Widget _showListDetail(RendimientoList entity, BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          sizedBox(0, 7.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.94,
            decoration: containerFileds(),
            child: Column(
              children: [
                ranking(ponderacionKPI),
                Container(
                    width: size.width * 0.94,
                    decoration: containerFileds(),
                    //   child: _fields(context),
                    child: Column(children: [
                      CartesianChart(titulo: 'TU PERFORMANCE KPI'),
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
    //Text(entity.nombreEquipo);
  }

  Widget listViewGauge(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        RendimientoList entity = snapshot.data[index];
        // return accordionWidget(
        //     Text('PROGRESO DE VENTA: ${entity.montoVendido}  ${entity.moneda}'),
        nombreCompleto = entity.nombreCompleto;
        comisionKPI = entity.comisionKPI.round().toString();
        totalComision = entity.totalComision.round().toString();
        porcentajeKPI = entity.porcentajeKPI.round().toString();
        moneda = entity.moneda;
        ponderacionKPI = entity.ponderacionKPI;
        return _showListTile(entity, context);
        // Colors.red,
        // Colors.green,
        // true);
      },
    );
  }

  Widget _showListTile(RendimientoList entity, BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 2.0),
          Container(
            width: size.width * 0.94,
            decoration: containerFileds(),
            //   child: _fields(context),
            child: Column(
              children: [
                Row(
                  children: [
                    sizedBox(8.0, 3.0),
                    Shimmer.fromColors(
                        baseColor: AppTheme.themeDefault,
                        highlightColor: AppTheme.themeGreen,
                        child: Text('PROGRESO DE VENTA :  '.toUpperCase(),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                    Shimmer.fromColors(
                        baseColor: AppTheme.themeRed,
                        highlightColor: AppTheme.themeGreen,
                        child: Text(
                            '${entity.montoVendido.round()}  ${entity.moneda}',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 22,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
                Row(
                  children: [
                    sizedBox(8.0, 3.0),
                    Text('Objetivo del MEs       :  '.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Text('${entity.limite.round()}  ${entity.moneda}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    sizedBox(8.0, 3.0),
                    Text('Tu bono Cump. PPTo.:  '.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Text('${entity.comision.round()} ${entity.moneda}',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          sizedBox(0.0, 8.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.94,
            decoration: containerFileds(),
            child: Column(
              children: [
                //   Row(
                //   children: [
                //     //    Text('Monto ventido por ti ${entity.montoVendido}'),
                //     Text('PROGRESO DE VENTA:'.toUpperCase()),
                //     Text('${entity.montoVendido}  ${entity.moneda}'),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text('Objetivo del MEs:'.toUpperCase()),
                //     Text('${entity.limite}  ${entity.moneda}'),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text('Tu bono Cump. PPTo.:'),
                //     Text('${entity.comision} ${entity.moneda}'),
                //   ],
                // ),

                GaugeColor(
                  textoInterior: entity.pocentaje.round().toString(),
                  textoInferior: "% Cump. PPTo.",
                  valor: entity.pocentaje,
                  colorAguja: entity.color,
                  venta: entity.montoVendido,
                  moneda: entity.moneda,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    //Text(entity.nombreEquipo);
  }
//# fin del Gauge

  Widget _futureBuilderList(BuildContext context) {
    entityDetalle.apiUrl =
        "http://amasventas.neuronatexnology.com/api/GetIndicadores/GetVentasMesDetalle/durioste";
    return FutureBuilder(
        future: new Repository().getData(entityDetalle),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return accordionWidget(
                  Row(
                    children: [
                      FaIcon(FontAwesomeIcons.fileInvoice, color: Colors.white),
                      sizedBox(10.0, 0.0),
                      Text("VALORACIÓN               PONDERACIÓN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  listViewList(context, snapshot),
                  Colors.blueGrey,
                  Colors.blueGrey,
                  true);

            //return listViewList(context, snapshot);
          }
        });
  }

  Widget listViewList(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          RendimientoDetalleList entity = snapshot.data[index];
          return Column(
            children: [
              _showList(entity, context),
              sizedBox(0.0, 5.0),
            ],
          );
        },
      );
    } else {
      return Container();
    }
  }

  Widget _showList(RendimientoDetalleList entity, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.98,
      margin: EdgeInsets.symmetric(vertical: 0.0),
      decoration: boxDecoration(),
      child: ListTile(
        title: Text(entity.pregunta,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
        trailing: Text(entity.ponderacion.toString(),
            style: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );
    //Text(entity.nombreEquipo);
  }
}
