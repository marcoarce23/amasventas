import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/RendimientoModel.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/VentasGastosModel.dart';
import 'package:amasventas/src/page/home/Menu.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:amasventas/src/widget/Dashboard/ColumnCompare.dart';

import 'package:amasventas/src/widget/Dashboard/ColumnInside.dart';
import 'package:amasventas/src/widget/Dashboard/ColumnStack.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';

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

class VentaPage extends StatefulWidget {
  static final String routeName = 'VentaPage';

  @override
  _VentaPageState createState() => _VentaPageState();
}

class _VentaPageState extends State<VentaPage>
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

  String presupuesto = '';
  String puntualidad = '';
  String depto = '';
  String area = '';
  String personal = '';
  String empresa = '';
  String valorPresupuesto = 'N';
  String valorPuntualidad = 'N';
  String valorDepto = 'N';
  String valorArea = 'N';
  String valorPersonal = 'N';
  double porcentajePresupuesto = 0;
  double porcentajePuntualidad = 0;
  double porcentajeDepto = 0;
  double porcentajeArea = 0;
  double porcentajePersonal = 0;
  //DEFINICION DE VARIABLES

  double venta = 0;
  double gasto = 0;
  double percent = 0.0;
  var size;

  String list3Detalle = '';
  double list3Presupeustado = 0;
  double list3Ejecutado = 0;

  String list2Detalle = '';
  double list2Presupeustado = 0;
  double list2Ejecutado = 0;

  @override
  void initState() {
    // Timer timer;
    // timer = Timer.periodic(Duration(milliseconds: 300), (_) {
    //   print('Percent Update');
    //   setState(() {
    //     percent += 1;
    //     if (percent >= 100) {
    //       timer.cancel();
    //       // percent=0;
    //     }
    //   });
    // });

    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 10000));
    _futureBuilderGauge(context);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

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
          iconTheme: IconThemeData(color: AppTheme.themeWhite, size: 16),
          elevation: 9.0,
          title: Text('AMASZONAS DIGITAL'.toUpperCase(),
              style: TextStyle(
                color: AppTheme.themeWhite,
                fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                fontSize: 19,
              )),
          actions: <Widget>[
            avatarCircle(IMAGE_LOGON, 35.0),
          ],
        ),
        drawer: DrawerMenu(),
        body: _formPrincipal(context),
        floatingActionButton: floatButton(AppTheme.themeGreen, context,
            FaIcon(FontAwesomeIcons.arrowLeft), MenuPage(opt: 'AMP')),
      ),
    );
  }

  Widget _formPrincipal(BuildContext context) {
    return Stack(
      children: <Widget>[
        _form(context),
        //  sizedBox(0.0, 10),
        _totalGeneral(context),
        // copyRigthBlack(),
      ],
    );
  }

  Widget _form(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            sizedBox(0.0, 4.0),
            _cabecera(),
            dividerGreen(),
            sizedBox(0.0, 5.0),
            _notakpiGeneral(context),
            sizedBox(0.0, 10.0),
            //   dividerGreen(),
            sizedBox(0.0, 10.0),
            _notaAreaGeneral(context),
            sizedBox(0.0, 10.0),
            //  dividerGreen(),
            sizedBox(0.0, 10.0),
            _notaDeptoGeneral(context),
            sizedBox(0.0, 10.0),
            // dividerGreen(),
            sizedBox(0.0, 10.0),
            _notaPuntualidadGeneral(context),
            sizedBox(0.0, 10.0),
            // dividerGreen(),
            sizedBox(0.0, 10.0),
            _notaPresupuestoGeneral(context),
            sizedBox(0.0, 10.0),
            // dividerGreen(),
            sizedBox(0.0, 10.0),
            _notaPersonalGeneral(context),
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
      list2Detalle = lista[0].list2[0].detalle;
      list2Presupeustado = lista[0].list2[0].presupuestado;
      list2Ejecutado = lista[0].list2[0].ejecutado;

      list3Detalle = lista[0].list3[0].detalle;
      list3Presupeustado = lista[0].list3[0].presupuestado;
      list3Ejecutado = lista[0].list3[0].ejecutado;
      _cargarDatos(lista[0]);
    });
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
    presupuesto = entity.presupuesto;
    puntualidad = entity.puntualidad;
    depto = entity.depto;
    area = entity.area;
    personal = entity.personal;
    empresa = entity.empresa;
    valorPresupuesto = entity.valorPresupuesto;
    valorPuntualidad = entity.valorPuntualidad;
    valorDepto = entity.valorDepto;
    valorArea = entity.valorArea;
    valorPersonal = entity.valorPersonal;
    porcentajePresupuesto = entity.porcentajePresupuesto;
    porcentajePuntualidad = entity.porcentajePuntualidad;
    porcentajeDepto = entity.porcentajeDepto;
    porcentajeArea = entity.porcentajeArea;
    porcentajePersonal = entity.porcentajePersonal;
  }

  Widget _cabecera() {
    return Container(
      decoration: boxDecoration(),
      width: size.width * 0.94,
      child: Column(
        children: <Widget>[
          Column(
            children: [
              sizedBox(0.0, 6.0),
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

  Widget _notaPresupuestoGeneral(BuildContext context) {
    if (valorPresupuesto == 'S') {
      return Column(children: [
        _cabeceraGeneral('$presupuesto', '${porcentajePresupuesto.toString()}',
            AppTheme.themeGreen),
        accordionWidget(
            Row(
              children: [
                sizedBox(5, 2.0),
                FaIcon(FontAwesomeIcons.eye, color: AppTheme.themeBlackGrey),
                sizedBox(5, 0.0),
                Text('VER DETALLE'.toUpperCase(),
                    style: TextStyle(
                        color: AppTheme.themeBlackGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                sizedBox(15, 2.0),
              ],
            ),
            Column(
              children: [
                liquidIndicatorTitle(
                    '${porcentajePresupuesto.toString()}',
                    20,
                    '${porcentajePresupuesto.toString()}%',
                    'Aceptable',
                    Colors.green,
                    130,
                    130),
              ],
            ),
            AppTheme.themeWhite,
            AppTheme.themeWhite,
            false),
        _notaSubtotal(context, vdkpipre.toString(), moneda),
      ]);
    } else
      return Container();
  }

  Widget _notaDeptoGeneral(BuildContext context) {
    if (valorDepto == 'S') {
      return Column(children: [
        _cabeceraGeneral(
            '$depto', '${porcentajeDepto.toString()}', AppTheme.themeGreen),
        accordionWidget(
            Row(
              children: [
                sizedBox(5, 2.0),
                FaIcon(FontAwesomeIcons.eye, color: AppTheme.themeBlackGrey),
                sizedBox(5, 0.0),
                Text('VER DETALLE'.toUpperCase(),
                    style: TextStyle(
                        color: AppTheme.themeBlackGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                sizedBox(15, 2.0),
              ],
            ),
            Column(
              children: [
                ColumnCompare(
                    labelVentas: 'Presupuestado',
                    labelPagos: 'Ejecutado',
                    doubleVentas: list3Presupeustado,
                    doublePagos: list3Ejecutado,
                    titulo: list3Detalle),
                // liquidIndicatorTitle(
                //     '${porcentajeDepto.toString()}',
                //     20,
                //     '${porcentajeDepto.toString()}%',
                //     'Aceptable',
                //     Colors.green,
                //     130,
                //     130),
              ],
            ),
            AppTheme.themeWhite,
            AppTheme.themeWhite,
            false),
        _notaSubtotal(context, vdkpidep.toString(), moneda),
      ]);
    } else
      return Container();
  }

  Widget _notaPersonalGeneral(BuildContext context) {
    if (valorPersonal == 'S') {
      return Column(children: [
        _cabeceraGeneral('$empresa', '${porcentajePersonal.toString()}',
            AppTheme.themeGreen),
        // accordionWidget(
        //     Row(
        //       children: [
        //         sizedBox(5, 2.0),
        //         FaIcon(FontAwesomeIcons.eye, color: AppTheme.themeBlackGrey),
        //         sizedBox(5, 0.0),
        //         Text('VER DETALLE'.toUpperCase(),
        //             style: TextStyle(
        //                 color: AppTheme.themeBlackGrey,
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.bold)),
        //         sizedBox(15, 2.0),
        //       ],
        //     ),

        // Column(
        //   children: [
        //     liquidIndicatorTitle(
        //         '${porcentajePersonal.toString()}',
        //         20,
        //         '${porcentajePersonal.toString()}%',
        //         'Aceptable',
        //         Colors.green,
        //         130,
        //         130),
        //   ],
        // ),

        // AppTheme.themeWhite,
        // AppTheme.themeWhite,
        // false),

        _futureBuilderBarras(context),
        _notaSubtotal(context, vdkpiemp.toString(), moneda),
      ]);
    } else
      return Container();
  }

  Widget _notakpiGeneral(BuildContext context) {
    return Column(children: [
      _neutro('$personal'),
      _futureBuilderList(context),
      _notaKPI(context),
    ]);
  }

  Widget _notaKPI(BuildContext context) {
    return Container(
        width: size.width * 0.95,
        decoration: containerFileds1(Colors.blue),
        child: Column(
          children: [
            sizedBox(0, 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBox(15, 2.0),
                Text('$comisionKPI $moneda',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            sizedBox(0, 10.0),
          ],
        ));
  }

  Widget _notaSubtotal(BuildContext context, String valors, String monedas) {
    return Container(
        width: size.width * 0.95,
        decoration: containerFileds1(Colors.blue),
        child: Column(
          children: [
            sizedBox(0, 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBox(15, 2.0),
                Text('$valors $monedas',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            sizedBox(0, 10.0),
          ],
        ));
  }

  Widget _notaPuntualidadGeneral(BuildContext context) {
    if (valorPuntualidad == 'S') {
      return Column(children: [
        _cabeceraGeneral('$puntualidad', '${porcentajePuntualidad.toString()}',
            AppTheme.themeGreen),
        accordionWidget(
            Row(
              children: [
                sizedBox(5, 2.0),
                FaIcon(FontAwesomeIcons.eye, color: AppTheme.themeBlackGrey),
                sizedBox(5, 0.0),
                Text('VER DETALLE'.toUpperCase(),
                    style: TextStyle(
                        color: AppTheme.themeBlackGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                sizedBox(15, 2.0),
              ],
            ),
            Column(
              children: [
                liquidIndicatorTitle(
                    '${porcentajePuntualidad.toString()}',
                    20,
                    '${porcentajePuntualidad.toString()}%',
                    'Aceptable',
                    Colors.green,
                    130,
                    130),
              ],
            ),
            AppTheme.themeWhite,
            AppTheme.themeWhite,
            false),
        _notaSubtotal(context, vdkpipun.toString(), moneda),
      ]);
    } else
      return Container();
  }

  Widget _cabeceraGeneral(String titulo, String valor, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: boxDecorationColor(color),
      width: size.width * 0.94,
      child: Column(
        children: <Widget>[
          // sizedBox(0.0, 5.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizedBox(7, 0),
                  liquidIndicator('$valor', 14, '$valor%', Colors.grey, 45, 44),
                  sizedBox(5, 0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Center(
                        child: Text(titulo.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTheme.themeWhite,
                                //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                fontSize: 15.5,
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

  Widget _notaAreaGeneral(BuildContext context) {
    if (valorPresupuesto == 'S') {
      return Column(children: [
        _cabeceraGeneral(
            '$area', '${porcentajeArea.toString()}', AppTheme.themeGreen),
        accordionWidget(
            Row(
              children: [
                sizedBox(5, 2.0),
                FaIcon(FontAwesomeIcons.eye, color: AppTheme.themeBlackGrey),
                sizedBox(5, 0.0),
                Text('VER DETALLE'.toUpperCase(),
                    style: TextStyle(
                        color: AppTheme.themeBlackGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                sizedBox(15, 2.0),
              ],
            ),
            Column(
              children: [
                ColumnCompare(
                    labelVentas: 'Presupuestado',
                    labelPagos: 'Ejecutado',
                    doubleVentas: list2Presupeustado,
                    doublePagos: list2Ejecutado,
                    titulo: list2Detalle),
                // liquidIndicatorTitle(
                //     '${porcentajeDepto.toString()}',
                //     20,
                //     '${porcentajeDepto.toString()}%',
                //     'Aceptable',
                //     Colors.green,
                //     130,
                //     130),
              ],
            ),
            AppTheme.themeWhite,
            AppTheme.themeWhite,
            false),

        //_futureBuilderBarras(context),
        _notaSubtotal(context, vdkpiare.toString(), moneda),
      ]);
    } else
      return Container();
  }

  Widget _totalGeneral(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.005,
      width: size.width * 0.96,
      left: 7.5,
      child: Container(
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
    );
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
        return Container();
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
                      Text("VALORACIÓN        PONDERACIÓN",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),

                      InkWell(
                        onTap: () {
                          _futureBuilderGauge(context);
                        },
                        child: FaIcon(
                          FontAwesomeIcons.sync,
                          color: AppTheme.themeBlackGrey,
                          size: 20,
                        ),
                      ),
                      sizedBox(0, 5.0),
                    ],
                  ),
                  listViewList(context, snapshot),
                  AppTheme.themeWhite,
                  AppTheme.themeWhite,
                  false);
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

    return Container(
      alignment: Alignment.center,
      decoration: boxDecorationColor(AppTheme.themeGreen),
      width: size.width * 0.94,
      child: Column(
        children: <Widget>[
          // sizedBox(0.0, 5.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizedBox(10, 0),
                  Image.network(
                    urlEstrella,
                    height: 45,
                    width: 45,
                  ),
                  sizedBox(8, 0),
                  Shimmer.fromColors(
                      baseColor: AppTheme.themeWhite,
                      highlightColor: Colors.yellow,
                      child: Center(
                        child: Text(neutro.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTheme.themeWhite,
                                //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                                fontSize: 20,
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
  Widget _futureBuilderBarras(BuildContext context) {
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
            sizedBox(5, 2.0),
            FaIcon(FontAwesomeIcons.eye, color: AppTheme.themeBlackGrey),
            sizedBox(5, 0.0),
            Text('VER DETALLE'.toUpperCase(),
                style: TextStyle(
                    color: AppTheme.themeBlackGrey,
                    //fontFamily: FONT_FAMILY_CM_SANS_SERIF,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            sizedBox(15, 2.0),
          ],
        ),
        Container(
          height: 400,
          child: ColumnStack(
            ventas: 210000,
            listaGasto: listaDetalle,
          ),
        ),
        AppTheme.themeWhite,
        AppTheme.themeWhite,
        false);
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
}
