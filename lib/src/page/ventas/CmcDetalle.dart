import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/VentasGastosModel.dart';
import 'package:amasventas/src/page/ventas/CmcDetail.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:amasventas/src/widget/Dashboard/ColumnCompare.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';

import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CmcDetallePage extends StatefulWidget {
  static final String routeName = 'cmcDetalle';

  @override
  _CmcDetallePagePageState createState() => _CmcDetallePagePageState();
  int nivel;
  String gestion;
  String periodo;
  int idPresupuestoGasto;

  CmcDetallePage(
      {this.nivel, this.gestion, this.periodo, this.idPresupuestoGasto});
}

class _CmcDetallePagePageState extends State<CmcDetallePage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  CmcAreaDetalleList entityDetalle = new CmcAreaDetalleList();
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
            FaIcon(FontAwesomeIcons.arrowLeft, size: 32), CmcDetailPage()),
      ),
    );
  }

  Widget _comboMes() {
    return Row(
      children: <Widget>[
        SizedBox(width: 0.0),
        Text('PERIODO:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 5.0),
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
        SizedBox(width: 10.0),
        Text('GESTION:', style: TextStyle(fontWeight: FontWeight.bold)),
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
            sizedBox(0.0, 4.0),
            _header(),
            sizedBox(0.0, 5.0),
            Container(
              width: size.width * 0.95,
              decoration: boxDecoration(),
              child: Row(
                children: [
                  sizedBox(5.0, 0.0),
                  Text('AREA:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('TI:'),
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
        "http://amasventas.neuronatexnology.com/api/DashBoard/GetDashBoardGeneral/nivel/" +
            widget.nivel.toString() +
            "/gestion/" +
            widget.gestion +
            "/periodo/" +
            widget.periodo +
            "/presupuesto/" +
            widget.idPresupuestoGasto.toString();
    print('XXXX: ${entityDetalle.apiUrl}');

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
        CmcAreaDetalleList entity = snapshot.data[index];
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
          sizedBox(0.0, 5.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  sizedBox(5, 2.0),
                  // Shimmer.fromColors(
                  //     baseColor: AppTheme.themeWhite,
                  //     highlightColor: Colors.yellow,
                  //     child: Row(
                  //       children: [
                  //         Text('Area',
                  //             style: TextStyle(
                  //                 color: AppTheme.themeWhite,
                  //                 //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold)),
                  //       ],
                  //     )),
                  // sizedBox(20, 2.0),

                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Row(
                        children: [
                          Text('Anual (Bs.)',
                              style: TextStyle(
                                  color: AppTheme.themeWhite,
                                  //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                  sizedBox(14, 2.0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Row(
                        children: [
                          Text('Acum. (Bs.)',
                              style: TextStyle(
                                  color: AppTheme.themeWhite,
                                  //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                  sizedBox(12, 2.0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Row(
                        children: [
                          Text('Cump.[%]',
                              style: TextStyle(
                                  color: AppTheme.themeWhite,
                                  //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                  sizedBox(25, 2.0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Row(
                        children: [
                          Text('Item',
                              style: TextStyle(
                                  color: AppTheme.themeWhite,
                                  //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                  sizedBox(45, 2.0),
                ],
              ),
              sizedBox(0, 5.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showListTileGauge(CmcAreaDetalleList entity, BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 5.0),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.97,
            decoration: containerFileds1(Colors.white),
            child: Row(
              children: [
                // sizedBox(0.0, 5.0),
                // sizedBox(10.0, 8.0),
                // Text(
                //   entity.area.toString(),
                // ),
                sizedBox(15.0, 8.0),

                Text(
                  NumberFormat.currency(
                          locale: 'eu',
                          decimalDigits: 0,
                          customPattern: '#,###,###')
                      .format(entity.programado),
                ),
                sizedBox(40.0, 20.0),
                Text(
                  NumberFormat.currency(
                          locale: 'eu',
                          decimalDigits: 0,
                          customPattern: '#,###,###')
                      .format(entity.ejecutado),
                ),
                sizedBox(45.0, 0.0),
                Container(
                  // width: 40,
                  decoration: boxDecoration(),
                  child: Text(
                    NumberFormat.currency(
                                locale: 'eu',
                                decimalDigits: 0,
                                customPattern: '#,###,###')
                            .format(entity.cumplimiento) +
                        '%',
                    style: TextStyle(
                        backgroundColor: Colors.blue, color: Colors.white),
                  ),
                ),
                sizedBox(20.0, 0.0),
                Text(
                  entity.item.toString(),
                ),
                sizedBox(20.0, 5.0),
              ],
            ),
            // sizedBox(0.0, 5.0),
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

//# fin del Gauge
}
