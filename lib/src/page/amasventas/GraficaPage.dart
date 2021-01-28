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

class GraficaPage extends StatefulWidget {
  static final String routeName = 'GraficaPage';

  @override
  _GraficaPageState createState() => _GraficaPageState();
}

class _GraficaPageState extends State<GraficaPage>
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
    super.initState();
  }

  @override
  void dispose() {
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
            _mostrar(context),
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

  Widget _mostrarGrafica(BuildContext context) {
    if (valorPersonal == 'S') {
      return Column(children: [
        _cabeceraGeneral('$empresa', '${porcentajePersonal.toString()}',
            AppTheme.themeGreen),
        _futureBuilderBarras(context),
      ]);
    } else
      return Container();
  }

  Widget _notakpiGeneral(BuildContext context) {
    return Column(children: [
      _futureBuilderList(context),
    ]);
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

  Widget _mostrar(BuildContext context) {
    return Column(children: [
      Column(
        children: [
          ColumnCompare(
              labelVentas: '2020-Diciembre',
              labelPagos: '2021-Enero',
              doubleVentas: 538,
              doublePagos: 538,
              titulo: 'Reporte Semestral Generado Correctamente'),
        ],
      ),

      //_futureBuilderBarras(context),
    ]);
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
