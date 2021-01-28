import 'dart:ui';

import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/crosscutting/Utils.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/VentasGastosModel.dart';

import 'package:amasventas/src/page/ventas/CmcDetalle.dart';
import 'package:amasventas/src/page/ventas/VentasGastos.dart';
import 'package:amasventas/src/repository/Repository.dart';

import 'package:amasventas/src/widget/Dashboard/ColumnCompare.dart';
import 'package:amasventas/src/widget/Dashboard/ColumnInside.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CmcDetailPage extends StatefulWidget {
  static final String routeName = 'resultados';

  @override
  _CmcDetailPageState createState() => _CmcDetailPageState();
}

class _CmcDetailPageState extends State<CmcDetailPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  VentasGastosList entity = new VentasGastosList();
  VentasGastosDetalleList entityDetalle = new VentasGastosDetalleList();
  final prefs = new Preferense();

  //DEFINICION DE VARIABLES

  double venta = 0;
  double gasto = 0;
  var size;
  String _opcionMes = 'OCT';
  String _opcionGestion = '2020';
  List<String> _cantidadMes = [
    'ENE',
    'FEB',
    'MAR',
    'ABR',
    'MAY',
    'JUN',
    'JUL',
    'AGO',
    'SEP',
    'OCT',
    'NOV',
    'DIC',
  ];

  List<String> _cantidadAnio = [
    '2019',
    '2020',
  ];

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

//sssss
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        appBar: //appBar('VENTAS & GASTOS'),
            AppBar(
          backgroundColor: AppTheme.themeGreen,
          shadowColor: Colors.black,
          //toolbarOpacity: 0.7,
          iconTheme: IconThemeData(color: AppTheme.themeWhite, size: 16),
          elevation: 9.0,
          title: Text('AMASZONAS DIGITAL'.toUpperCase(),
              style: TextStyle(
                color: AppTheme.themeWhite,
                fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                fontSize: 19,
              )),
          actions: <Widget>[
            //  DrawerMenu(),
            avatarCircle(IMAGE_LOGON, 35.0),
          ],
        ),
        drawer: DrawerMenu(),
        body: pestania2(context),
        floatingActionButton: floatButton(AppTheme.themeGreen, context,
            FaIcon(FontAwesomeIcons.arrowLeft, size: 32), VentaGastoPage()),
      ),
    );
  }

  Widget _comboMes() {
    return Row(
      children: <Widget>[
        SizedBox(width: 35.0),
        Text('PERIODO :'),
        SizedBox(width: 15.0),
        DropdownButton(
          value: _opcionMes,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeWhite),
          items: _countMes(),
          onChanged: (opt) {
            setState(() {
              _opcionMes = opt;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _countMes() {
    List<DropdownMenuItem<String>> lista = new List();

    _cantidadMes.forEach((cantidadMes) {
      lista.add(DropdownMenuItem(
        child: Text(cantidadMes),
        value: cantidadMes,
      ));
    });
    return lista;
  }

  Widget _comboGestion() {
    return Row(
      children: <Widget>[
        SizedBox(width: 35.0),
        Text('Gestión:'),
        SizedBox(width: 15.0),
        DropdownButton(
          value: _opcionGestion,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeWhite),
          items: _countGestion(),
          onChanged: (opt) {
            setState(() {
              _opcionGestion = opt;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _countGestion() {
    List<DropdownMenuItem<String>> lista = new List();

    _cantidadAnio.forEach((cantidadAnio) {
      lista.add(DropdownMenuItem(
        child: Text(cantidadAnio),
        value: cantidadAnio,
      ));
    });
    return lista;
  }

  Widget pestania2(BuildContext context) {
    return Stack(
      children: <Widget>[
        _formGauge(context),
      ],
    );
  }

  Widget pestania1(BuildContext context) {
    return Stack(
      children: <Widget>[
        _form(context),
      ],
    );
  }

  Widget _formGauge(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            sizedBox(0.0, 5.0),
            _header(),
            sizedBox(0.0, 5.0),
            Container(
              width: size.width * 0.95,
              decoration: boxDecoration(),
              child: Row(
                children: [
                  _comboGestion(),
                  _comboMes(),
                ],
              ),
            ),
            dividerGreen(),
            _cabeceraGrilla(),
            _futureBuilderGauges(context),
            copyRigthBlack(),
          ],
        ),
      ),
    );
  }

  Widget _futureBuilderGauges(BuildContext context) {
    entityDetalle.apiUrl =
        "http://amasventas.neuronatexnology.com/api/DashBoard/GetGastoDetalle";
    return FutureBuilder(
        future: new Repository().getData(entityDetalle),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listViewColumGauge(context, snapshot);
          }
        });
  }

  Widget listViewColumGauge(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        VentasGastosDetalleList entity = snapshot.data[index];
        return _showListTileGauge(entity, context);
        // Colors.red,
        // Colors.green,
        // true);
      },
    );
  }

  Widget _cabeceraGrilla() {
    return Container(
      decoration: boxDecorationColor(AppTheme.themeGreen),
      width: size.width * 0.97,
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 7.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  sizedBox(15, 2.0),
                  Shimmer.fromColors(
                    baseColor: AppTheme.themeWhite,
                    highlightColor: Colors.yellow,
                    child: FaIcon(
                      FontAwesomeIcons.chartBar,
                      color: AppTheme.themeWhite,
                      size: 18,
                    ),
                  ),
                  sizedBox(8, 0.0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Row(
                        children: [
                          Text('Area',
                              style: TextStyle(
                                  color: AppTheme.themeWhite,
                                  //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                  sizedBox(60, 2.0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Row(
                        children: [
                          Text('Anual',
                              style: TextStyle(
                                  color: AppTheme.themeWhite,
                                  //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                  sizedBox(30, 2.0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Row(
                        children: [
                          Text('Acumulado',
                              style: TextStyle(
                                  color: AppTheme.themeWhite,
                                  //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                  sizedBox(5, 2.0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Row(
                        children: [
                          Text('Mensual',
                              style: TextStyle(
                                  color: AppTheme.themeWhite,
                                  //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                ],
              ),
              sizedBox(0, 5.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showListTileGauge(
      VentasGastosDetalleList entity, BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 5.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.97,
            decoration: containerFileds1(Colors.white),
            child: Row(
              children: [
                ZoomIn(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          navegation(
                              context,
                              CmcDetallePage(
                                nivel: 4,
                                gestion: '2020',
                                periodo: 'oct',
                                idPresupuestoGasto: 7,
                              ));
                        },
                        child: avatarCircle(IMAGE_LOGON, 40),

                        // _crearBotonRedondeado(Colors.blueAccent,
                        // Icons.movie_filter, entity.detalle, MenuPage()),

                        // FaIcon(FontAwesomeIcons.edit,
                        //   color: Colors.pink, size: 40),
                      ),
                      sizedBox(0.0, 8.0),
                      Text(
                        entity.detalle.toString(),
                        //  style: GoogleFonts.getFont('Lato',
                        //    fontWeight: FontWeight.bold)
                      ),
                      Text(
                        '      Ejecutado      (Bs.):',
                        //   style: GoogleFonts.getFont('Lato', fontSize: 13)
                      ),
                      Text(
                        '     Programado (Bs.):',
                        //     style: GoogleFonts.getFont('Lato', fontSize: 13)
                      ),
                    ],
                  ),
                ),
                sizedBox(16.0, 0.0),
                ZoomIn(
                  child: Column(
                    children: [
                      sizedBox(0.0, 5.0),
                      showPictureOval(
                          ejecutadoPorcent(
                              entity.anualEjecutado, entity.anualProgramado),
                          55,
                          colorPorcent(
                              entity.anualEjecutado, entity.anualProgramado),
                          ejecutado(
                              entity.anualEjecutado, entity.anualProgramado)),
                      sizedBox(0.0, 20.0),
                      Text(
                        NumberFormat.currency(
                                locale: 'eu',
                                decimalDigits: 0,
                                customPattern: '#,###,###')
                            .format(entity.anualEjecutado),
                        //  style: GoogleFonts.getFont('Lato', fontSize: 13),
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: 'eu',
                                decimalDigits: 0,
                                customPattern: '#,###,###')
                            .format(entity.anualProgramado),
                        //      style: GoogleFonts.getFont('Lato', fontSize: 13),
                      ),
                    ],
                  ),
                ),
                sizedBox(16.0, 0.0),
                ZoomIn(
                  child: Column(
                    children: [
                      sizedBox(0.0, 5.0),
                      showPictureOval(
                          ejecutadoPorcent(entity.acumuladoEjecutado,
                              entity.acumuladoProgramado),
                          55,
                          colorPorcent(entity.acumuladoEjecutado,
                              entity.acumuladoProgramado),
                          ejecutado(entity.acumuladoEjecutado,
                              entity.acumuladoProgramado)),
                      sizedBox(0.0, 20.0),
                      Text(
                        NumberFormat.currency(
                                locale: 'eu',
                                decimalDigits: 0,
                                customPattern: '#,###,###')
                            .format(entity.acumuladoEjecutado),
                        //   style: GoogleFonts.getFont('Lato', fontSize: 13),
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: 'eu',
                                decimalDigits: 0,
                                customPattern: '#,###,###')
                            .format(entity.acumuladoProgramado),
                        //    style: GoogleFonts.getFont('Lato', fontSize: 13),
                      ),
                    ],
                  ),
                ),
                sizedBox(16.0, 0.0),
                ZoomIn(
                  child: Column(
                    children: [
                      sizedBox(0.0, 5.0),
                      showPictureOval(
                          ejecutadoPorcent(
                              entity.mesEjecutado, entity.mesProgramado),
                          55,
                          colorPorcent(
                              entity.mesEjecutado, entity.mesProgramado),
                          ejecutado(entity.mesEjecutado, entity.mesProgramado)),
                      sizedBox(0.0, 20.0),
                      Text(
                        NumberFormat.currency(
                                locale: 'eu',
                                decimalDigits: 0,
                                customPattern: '#,###,###')
                            .format(entity.mesEjecutado),
                        //  style: GoogleFonts.getFont('Lato', fontSize: 13),
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: 'eu',
                                decimalDigits: 0,
                                customPattern: '#,###,###')
                            .format(entity.mesProgramado),
                        //     style: GoogleFonts.getFont('Lato', fontSize: 13),
                      ),
                    ],
                  ),
                ),
                sizedBox(0.0, 8.0),
              ],
            ),
          ),
        ],
      ),
    );
    //Text(entity.nombreEquipo);
  }

  Widget _form(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            sizedBox(0.0, 6.0),
            _header(),
            sizedBox(0.0, 6.0),
            _cabecera(),
            _futureBuilderColumnCompare(context),
            sizedBox(0.0, 6.0),
            _neutro('NEUTRO'),
            sizedBox(0.0, 5.0),
            _fechaNeutro('OCTUBRE', '2020'),
            sizedBox(0.0, 6.0),
            copyRigthBlack(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      decoration: boxDecoration(),
      width: size.width * 0.94,
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 5.0),
          Column(
            children: [
              Row(
                children: [
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeGreen),
                  sizedBox(8, 0.0),
                  Text('Fecha actual : '.toUpperCase(),
                      style: TextStyle(
                          color: AppTheme.themeBlackBlack,
                          //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Text('${DateTime.now().toString().substring(0, 10)}',
                      style: TextStyle(
                          color: AppTheme.themeBlackBlack,
                          fontSize: 17,
                          //   fontFamily:  FONT_FAMILY_DANCING,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.user, color: AppTheme.themeGreen),
                  sizedBox(8, 0.0),
                  Text('Bienvenido       : '.toUpperCase(),
                      style: TextStyle(
                          color: AppTheme.themeBlackBlack,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Text(prefs.nameUser.toUpperCase(),
                      style: TextStyle(
                          color: AppTheme.themeBlackBlack,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              sizedBox(0, 5.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cabecera() {
    return Container(
      decoration: boxDecorationColor(AppTheme.themeGreen),
      width: size.width * 0.94,
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 2.0),
          Column(
            children: [
              Row(
                children: [
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.chartBar, color: AppTheme.themeWhite),
                  sizedBox(8, 0.0),
                  Text('VENTAS - GASTOS '.toUpperCase(),
                      style: TextStyle(
                          color: AppTheme.themeWhite,
                          //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              sizedBox(0, 2.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fechaNeutro(String periodo, String gestion) {
    return Container(
      decoration: boxDecoration(),
      width: size.width * 0.94,
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 6.0),
          Column(
            children: [
              Row(
                children: [
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.calendarAlt,
                      color: AppTheme.themeGreen),
                  sizedBox(8, 0.0),
                  Text(periodo.toUpperCase(),
                      style: TextStyle(
                          color: AppTheme.themeGreen,
                          //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.calendarCheck,
                      color: AppTheme.themeGreen),
                  sizedBox(8, 0.0),
                  Text(gestion.toUpperCase(),
                      style: TextStyle(
                          color: AppTheme.themeGreen,
                          //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              sizedBox(0, 6.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _neutro(String neutro) {
    return Container(
      decoration: boxDecorationColor(AppTheme.themeGreen),
      width: size.width * 0.94,
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 5.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  sizedBox(15, 2.0),
                  Shimmer.fromColors(
                    baseColor: AppTheme.themeWhite,
                    highlightColor: Colors.yellow,
                    child: FaIcon(
                      FontAwesomeIcons.balanceScale,
                      color: AppTheme.themeWhite,
                      size: 30,
                    ),
                  ),
                  sizedBox(8, 0.0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Text(neutro.toUpperCase(),
                          style: TextStyle(
                              color: AppTheme.themeWhite,
                              //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                              fontSize: 30,
                              fontWeight: FontWeight.bold))),
                ],
              ),
              sizedBox(0, 5.0),
            ],
          ),
        ],
      ),
    );
  }

//# inicio del Gauge
  Widget _futureBuilderColumnCompare(BuildContext context) {
    entity.apiUrl =
        "http://amasventas.neuronatexnology.com/api/DashBoard/GetVentasGasto";
    return FutureBuilder(
        future: new Repository().getData(entity),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listViewColumCompare(context, snapshot);
          }
        });
  }

  Widget listViewColumCompare(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        VentasGastosList entity = snapshot.data[index];
        return _showListTileColumCompare(entity, context);
        // Colors.red,
        // Colors.green,
        // true);
      },
    );
  }

  Widget _showListTileColumCompare(
      VentasGastosList entity, BuildContext context) {
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
              children: [],
            ),
          ),
          sizedBox(0.0, 8.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.94,
            decoration: containerFileds(),
            child: Column(
              children: [
                ColumnCompare(
                    labelVentas: 'Ingreso',
                    labelPagos: 'Costo',
                    doubleVentas: entity.ventas,
                    doublePagos: entity.gastos,
                    titulo: "INGRESO Vs. COSTO\n [Millones en BS.]"),
              ],
            ),
          ),
        ],
      ),
    );
    //Text(entity.nombreEquipo);
  }

  Widget _futureBuilderColumnDetail(BuildContext context) {
    final size = MediaQuery.of(context).size;
    entityDetalle.apiUrl =
        "http://amasventas.neuronatexnology.com/api/DashBoard/GetVentasGasto";
    return FutureBuilder(
        future: new Repository().getData(entityDetalle),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return Container(
                child: Column(
                  children: <Widget>[
                    sizedBox(0.0, 2.0),
                    Container(
                      width: size.width * 0.94,
                      decoration: containerFileds(),
                      //   child: _fields(context),
                      child: Column(
                        children: [],
                      ),
                    ),
                    sizedBox(0.0, 8.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      decoration: containerFileds(),
                      child: Column(
                        children: [listViewColumDetalle(context, snapshot)],
                      ),
                    ),
                  ],
                ),
              );
          }
        });
  }

  Widget listViewColumDetalle(BuildContext context, AsyncSnapshot snapshot) {
    List<ChartSampleDataColumnInside> chartData =
        List<ChartSampleDataColumnInside>();

    for (var i = 0; i < snapshot.data.length; i++) {
      VentasGastosDetalleList registro =
          (snapshot.data[i]) as VentasGastosDetalleList;
      ChartSampleDataColumnInside serie = ChartSampleDataColumnInside();
      serie.x = registro.detalle;
      serie.y = registro.mesProgramado;
      serie.yValue = registro.mesEjecutado;
      chartData.add(serie);
    }

    return ColumnInside(
        chartData: chartData,
        labelVentas: 'Ventas',
        labelPagos: 'Gastos',
        titulo: "VENTAS Vs. GASTOS (detalle)\n [Millones en BS.]");
  }

  Widget _crearBotonRedondeado(
      Color color, IconData icono, String texto, Widget widget) {
    return InkWell(
      onTap: () {
        navegation(
            context,
            CmcDetallePage(
              nivel: 4,
              gestion: '2020',
              periodo: 'oct',
              idPresupuestoGasto: 7,
            ));
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
                  child: Icon(icono, color: Colors.white, size: 30.0),
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

//# fin del Gauge
}
