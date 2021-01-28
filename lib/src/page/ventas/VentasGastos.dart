import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/MenuList.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/RendimientoModel.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/VentasGastosModel.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/page/home/Menu.dart';
import 'package:amasventas/src/page/ventas/CmcDetail.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/widget/Dashboard/ColumnInside.dart';
import 'package:amasventas/src/widget/Dashboard/ColumnStack.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class VentaGastoPage extends StatefulWidget {
  static final String routeName = 'resultados';

  @override
  _VentaGastoPageState createState() => _VentaGastoPageState();
}

class _VentaGastoPageState extends State<VentaGastoPage>
    with SingleTickerProviderStateMixin {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  RendimientoList entityGauge = new RendimientoList();
  RendimientoKPIList entityKPI = new RendimientoKPIList();
  RendimientoDetalleList entityDetalleRend = new RendimientoDetalleList();

  VentasGastosList entity = new VentasGastosList();
  VentasGastosDetalleList entityDetalle = new VentasGastosDetalleList();
  final prefs = new Preferense();

  AnimationController animationController;
  Animation<double> rotate;

  String totalComision = "0";
  String comisionKPI = "0";
  String porcentajeKPI = "0";
  String nombreCompleto = "Usuario Amaszonas";
  String moneda = "BS.";
  double ponderacionKPI = 0;
  double vdkpiare = 0;
  double vdkpidep = 0;
  double vdkpiemp = 0;
  double vdkpipre = 0;
  double vdkpipun = 0;

  //DEFINICION DE VARIABLES

  double venta = 0;
  double gasto = 0;
  var size;

  @override
  void initState() {
    _futureBuilderGauge(context);
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 10000));

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
        body: pestania1(context),
        floatingActionButton: floatButton(AppTheme.themeGreen, context,
            FaIcon(FontAwesomeIcons.arrowLeft), MenuPage(opt: 'AMP')),
      ),
    );
  }

  Widget pestania1(BuildContext context) {
    return Stack(
      children: <Widget>[
        _form(context),
      ],
    );
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
                Column(
                  children: [
                    sizedBox(0.0, 8.0),
                    FaIcon(
                      FontAwesomeIcons.edit,
                      color: AppTheme.themeBlackGrey,
                      size: 40,
                    ),
                    Text(entity.detalle.toString(), style: kValues),
                    Text('PROGRAMADO (BS.):', style: kValues),
                    Text('EJECUTADO (BS.):', style: kValues),
                  ],
                ),
                sizedBox(6.0, 0.0),
                Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.edit,
                      color: AppTheme.themeBlackGrey,
                      size: 40,
                    ),
                    Text(
                      entity.anualProgramado.round().toString(),
                      style: kProgramado,
                    ),
                    Text(
                      entity.anualEjecutado.round().toString(),
                      style: kEjecutado,
                    ),
                  ],
                ),
                sizedBox(13.0, 0.0),
                Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.edit,
                      color: AppTheme.themeBlackGrey,
                      size: 40,
                    ),
                    Text(
                      entity.acumuladoProgramado.round().toString(),
                      style: kProgramado,
                    ),
                    Text(
                      entity.acumuladoEjecutado.round().toString(),
                      style: kEjecutado,
                    ),
                  ],
                ),
                sizedBox(13.0, 0.0),
                Column(
                  children: [
                    avatarCircle(IMAGE_LOGO, 25),
                    Text(
                      entity.mesProgramado.round().toString(),
                      style: kProgramado,
                    ),
                    Text(
                      entity.mesEjecutado.round().toString(),
                      style: kEjecutado,
                    ),
                  ],
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
            _fechaNeutro('OCTUBRE', '2020'),
            sizedBox(0.0, 5.0),
            _neutro('PROMEDIO KPI'),
            sizedBox(0.0, 6.0),
            _showLevel(context),
            sizedBox(0.0, 5.0),
            sizedBox(0.0, 6.0),
            _cabeceraDetalleKPI(),
            _futureBuilderList(context),
            _detallePerformanceKPI(context),
            sizedBox(0.0, 6.0),
            _cabecera(),
            _futureBuilderColumnCompare(context),
            _actualizar('OCTUBRE', '2020'),
            sizedBox(0.0, 6.0),
            copyRigthBlack(),
          ],
        ),
      ),
    );
  }

  _futureBuilderGauge(BuildContext context) async {
    entityGauge.apiUrl =
        "http://amasventas.neuronatexnology.com/api/GetIndicadores/GetVentasMesIndicador/" +
            prefs.nameUser;

    List<RendimientoList> lista =
        await new Repository().getDataRendimientoList(entityGauge);
    setState(() {
      _cargarDatos(lista[0]);
    });

    /*
    return FutureBuilder(
        future: new Repository().getData(entityGauge),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listViewGauge(context, snapshot);
          }
        });
        */
  }

  _cargarDatos(RendimientoList entity) {
    print('sssss: ${entity.comisionKPI}');
    nombreCompleto = entity.nombreCompleto;
    comisionKPI = entity.comisionKPI.toString();
    totalComision = entity.totalComision.toString();
    porcentajeKPI = entity.porcentajeKPI.toString();
    moneda = entity.moneda;
    ponderacionKPI = entity.ponderacionKPI;
    vdkpiare = entity.vd_kpiare;
    vdkpidep = entity.vd_kpidep;
    vdkpiemp = entity.vd_kpiemp;
    vdkpipun = entity.vd_kpipun;
    vdkpipre = entity.vd_kpipre;
  }

  Widget listViewGauge(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        RendimientoList entity = snapshot.data[index];
        _cargarDatos(entity);

        //  });
        return Container();
//
      },
    );
  }

  Widget _futureBuilderList(BuildContext context) {
    entityDetalleRend.apiUrl =
        "http://amasventas.neuronatexnology.com/api/GetIndicadores/GetVentasMesDetalle/" +
            prefs.nameUser;
    return FutureBuilder(
        future: new Repository().getData(entityDetalleRend),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return accordionWidget(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Image.network(
                      //   'https://previews.123rf.com/images/koltukovalek/koltukovalek1610/koltukovalek161000002/66943350-vector-de-la-muestra-del-n%C3%BAmero-tres-quot-3-quot-ganador-del-tercer-lugar-en-estrella-faceta-amarilla-n%C3%BAmero.jpg',
                      //   height: 35,
                      //   width: 35,
                      // ),
                      //  FaIcon(FontAwesomeIcons.accessibleIcon, color: Colors.white),
                      sizedBox(10.0, 5.0),
                      Text("VALORACIÓN         PONDERACIÓN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),

                      InkWell(
                        onTap: () {
                          _futureBuilderGauge(context);
                        },
                        child: FaIcon(
                          FontAwesomeIcons.sync,
                          color: AppTheme.themeWhite,
                          size: 20,
                        ),
                      ),
                      sizedBox(0, 5.0),
                    ],
                  ),
                  listViewList(context, snapshot),
                  AppTheme.themeGreen,
                  AppTheme.themeGreen,
                  false);

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
              sizedBox(0.0, 10.0),
              _showList(entity, context),
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
      width: size.width * 0.94,
      margin: EdgeInsets.symmetric(vertical: 0.0),
      decoration: boxDecoration(),
      child: ListTile(
        title: AutoSizeText(
          entity.pregunta,
          style: GoogleFonts.getFont(
            'Lato',
          ),
          softWrap: true,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.justify,
          minFontSize: 13,
          maxFontSize: 14,
          maxLines: 1,
        ),
        trailing: Text(entity.ponderacion.toString(),
            style: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );
    //Text(entity.nombreEquipo);
  }

  Widget _cabeceraDetalleKPI() {
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
                  Text('VER DETALLE KPI '.toUpperCase(),
                      style: TextStyle(
                          color: AppTheme.themeWhite,
                          //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  sizedBox(15, 2.0),
                  // InkWell(
                  //   onTap: () {
                  //     navegation(context, CmcDetailPage());
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Text('Detalle  '.toUpperCase(),
                  //           style: TextStyle(
                  //               color: AppTheme.themeWhite,
                  //               //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.bold)),
                  //       FaIcon(
                  //         FontAwesomeIcons.eye,
                  //         color: AppTheme.themeWhite,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              sizedBox(0, 2.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cabeceraDetallePonderacion() {
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
                  sizedBox(15, 0),
                  Text("VALORACIÓN              PONDERACIÓN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  sizedBox(10, 0),
                  InkWell(
                    onTap: () {
                      _futureBuilderGauge(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.sync,
                      color: AppTheme.themeWhite,
                      size: 20,
                    ),
                  ),
                  sizedBox(0, 2.0),
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
          width: size.width * 0.96,
          decoration: containerFileds1(Colors.blue),
          child: Column(
            children: [
              Row(
                children: [
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.commentDollar, color: Colors.white),
                  sizedBox(15, 0.0),
                  Text('TU BONO DE INCENTIVO'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              sizedBox(0, 8.0),
            ],
          ),
        ),
        sizedBox(0, 10.0),
        Container(
            width: size.width * 0.96,
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
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                sizedBox(0, 10.0),
              ],
            )),
        sizedBox(0, 10.0),
        Container(
          width: size.width * 0.96,
          decoration: containerFileds1(Colors.green),
          child: Column(
            children: [
              sizedBox(0, 15.0),
              Row(
                children: [
                  sizedBox(15, 2.0),
                  FaIcon(FontAwesomeIcons.handHoldingUsd, color: Colors.white),
                  sizedBox(5, 0.0),
                  Text('TOTAL INCENTIVO: '.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text('$totalComision  $moneda',
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 20,
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
              Column(
                children: [
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
                    ],
                  ),
                  Text('$nombreCompleto',
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
              // Row(
              //   children: [
              //     sizedBox(15, 2.0),
              //     FaIcon(FontAwesomeIcons.chartBar, color: AppTheme.themeWhite),
              //     sizedBox(8, 0.0),
              //     Text('INGRESO - COSTOS '.toUpperCase(),
              //         style: TextStyle(
              //             color: AppTheme.themeWhite,
              //             //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold)),
              //     sizedBox(15, 2.0),
              //     InkWell(
              //       onTap: () {
              //         navegation(context, CmcDetailPage());
              //       },
              //       child: Row(
              //         children: [
              //           Text('Detalle  '.toUpperCase(),
              //               style: TextStyle(
              //                   color: AppTheme.themeWhite,
              //                   //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.bold)),
              //           FaIcon(
              //             FontAwesomeIcons.eye,
              //             color: AppTheme.themeWhite,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
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

  Widget _actualizar(String periodo, String gestion) {
    return Container(
      // decoration: boxDecoration(),
      width: size.width * 0.94,
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 6.0),
          Column(
            children: [
              Row(
                children: [
                  sizedBox(15, 2.0),
                  Text('ACTUALIZAR INFORMACIÓN',
                      style: TextStyle(
                          color: AppTheme.themeGreen,
                          //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                  sizedBox(10, 0.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _futureBuilderGauge(context);
                      });
                    },
                    child: FaIcon(
                      FontAwesomeIcons.sync,
                      color: AppTheme.themeGreen,
                      size: 25,
                    ),
                  ),
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
    String urlEstrella = "";

    switch (ponderacionKPI.round()) {
      case 0:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989909/Amaszonas/0_omg4lw.png';
        break;
      case 1:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989345/Amaszonas/1_ojm9gx.png';
        break;
      case 2:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989343/Amaszonas/2_trjwrz.png';
        break;
      case 3:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989344/Amaszonas/3_anrtny.png';
        break;
      case 4:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989342/Amaszonas/4_dkjxjc.png';
        break;
      case 5:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989342/Amaszonas/5_fbivwl.png';
        break;
      case 6:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989343/Amaszonas/6_h85hel.png';
        break;
      case 7:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989342/Amaszonas/7_aogsiz.png';
        break;
      case 8:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989343/Amaszonas/8_t065sh.png';
        break;
      case 9:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989344/Amaszonas/9_vgoh2x.png';
        break;
      case 10:
        urlEstrella =
            'https://res.cloudinary.com/deifrqssh/image/upload/v1603989343/Amaszonas/10_bd0isi.png';
        break;
      default:
    }
    ;

    return Container(
      alignment: Alignment.center,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizedBox(15, 2.0),
                  Image.network(
                    urlEstrella,
                    height: 55,
                    width: 55,
                  ),
                  sizedBox(8, 2.0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Center(
                        child: Text('$ponderacionKPI',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTheme.themeWhite,
                                //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      )),
                  sizedBox(25, 0.0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Center(
                        child: Text(neutro.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTheme.themeWhite,
                                //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
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

//# inicio del Gauge
  Widget _futureBuilderColumnCompare(BuildContext context) {
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
              return listViewColumCompare(context, snapshot);
          }
        });
  }

  Widget listViewColumCompare(BuildContext context, AsyncSnapshot snapshot) {
    List<VentasGastosDetalleList> listaDetalle =
        new List<VentasGastosDetalleList>();

    for (int i = 0; i < snapshot.data.length; i++) {
      VentasGastosDetalleList entity = snapshot.data[i];
      listaDetalle.add(entity);
    }
    return accordionWidget(
        Row(
          children: [
            sizedBox(15, 2.0),
            FaIcon(FontAwesomeIcons.chartBar, color: AppTheme.themeWhite),
            sizedBox(8, 0.0),
            Text('INGRESO - COSTOS '.toUpperCase(),
                style: TextStyle(
                    color: AppTheme.themeWhite,
                    //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            sizedBox(15, 2.0),
            InkWell(
              onTap: () {
                navegation(context, CmcDetailPage());
              },
              child: Row(
                children: [
                  Text('Detalle  '.toUpperCase(),
                      style: TextStyle(
                          color: AppTheme.themeWhite,
                          //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  FaIcon(
                    FontAwesomeIcons.eye,
                    color: AppTheme.themeWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 400,
          child: ColumnStack(
            ventas: 210000,
            listaGasto: listaDetalle,
          ),
        ),
        AppTheme.themeGreen,
        AppTheme.themeGreen,
        false);
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
        labelVentas: 'PRESUPUESTO',
        labelPagos: 'GASTOS',
        titulo: "PRESUPUESTO Vs. GASTOS (detalle)\n [Millones en $moneda]");
  }

//# fin del Gauge

  Widget _showLevel(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 5.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: containerFileds1(Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Column(
                children: [
                  sizedBox(0, 8.0),
                  Text('NIVELES DE CUMPLIMIENTO.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  sizedBox(0.0, 13.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //      sizedBox(10.0, 0),
                      Pulse(
                        duration: Duration(milliseconds: 5000),
                        infinite: true,
                        child: Column(
                          children: [
                            //showCircleShimer('P', 85, Colors.red, 0.9),
                            FaIcon(FontAwesomeIcons.walking),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Shimmer.fromColors(
                                  baseColor: AppTheme.themeGreen,
                                  highlightColor: Colors.yellowAccent,
                                  child: Text('INCENTIVO PERSONAL',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))),
                              sizedBox(10.0, 0),
                              Shimmer.fromColors(
                                  baseColor: AppTheme.themeBlackBlack,
                                  highlightColor: AppTheme.themeGreen,
                                  child: Text('$comisionKPI $moneda',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pinkAccent))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  sizedBox(0, 20),
                  ZoomIn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //      sizedBox(3.0, 0),
                        Column(
                          children: [
                            FaIcon(FontAwesomeIcons.building),
                            //showCircle('A', 75, Colors.brown, 0.9),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('INCENTIVO EJECUTADO PPTo AREA',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                sizedBox(10.0, 0),
                                Text('$vdkpiare $moneda',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox(0, 20),
                  ZoomIn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //        sizedBox(10.0, 0),
                        Column(
                          children: [
                            FaIcon(FontAwesomeIcons.warehouse),
                            //showCircle('D', 75, Colors.green, 0.9),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('INCENTIVO EJECUTADO PPTo DEPTO.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                sizedBox(10.0, 0),
                                Text('$vdkpidep $moneda',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox(0, 20),
                  ZoomIn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //      sizedBox(10.0, 0),
                        Column(
                          children: [
                            FaIcon(FontAwesomeIcons.planeDeparture),
                            //showCircle('P', 75, Colors.blue, 0.9),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('INCENTIVO PUNTUALIDAD VUELOS',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                sizedBox(10.0, 0),
                                Text('$vdkpipun $moneda',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox(0, 20),
                  ZoomIn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //       sizedBox(10.0, 0),
                        Column(
                          children: [
                            FaIcon(FontAwesomeIcons.moneyBill),
                            //showCircle('I', 75, Colors.orange, 0.9),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('INCENTIVO PRESUPUESTO INGRESOS',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                sizedBox(10.0, 0),
                                Text('$vdkpipre $moneda',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox(0, 20),
                  ZoomIn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //        sizedBox(10.0, 0),
                        Column(
                          children: [
                            FaIcon(FontAwesomeIcons.businessTime),
                            //showCircle('E', 75, Colors.red, 0.9),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('INCENTIVO EMPRESA.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                sizedBox(10.0, 0),
                                Text('$vdkpiemp $moneda',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox(0, 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    //Text(entity.nombreEquipo);
  }
}
