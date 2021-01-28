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

class SimuladorVentasPage extends StatefulWidget {
  static final String routeName = 'VentaPage';

  @override
  _SimuladorVentasPageState createState() => _SimuladorVentasPageState();
}

class _SimuladorVentasPageState extends State<SimuladorVentasPage>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  SimuladorList entityGauge = new SimuladorList();
  RendimientoKPIList entityKPI = new RendimientoKPIList();
  RendimientoDetalleList entityDetalleRend = new RendimientoDetalleList();

  VentasGastosList entity = new VentasGastosList();
  VentasGastosDetalleList entityDetalle = new VentasGastosDetalleList();
  final prefs = new Preferense();

  AnimationController animationController;
  Animation<double> rotate;

  TextEditingController controllerArea = TextEditingController();
  TextEditingController controllerDepto = TextEditingController();
  TextEditingController controllerPuntualidad = TextEditingController();
  TextEditingController controllerPpto = TextEditingController();
  TextEditingController controllerEmpresa = TextEditingController();
  TextEditingController controllerKPI = TextEditingController();

  String _initialValue = '0';
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

  String pvPER;
  String pvARE;
  String pvDEP;
  String pvPUN;
  String pvPRE;
  String pvEMP;

  String pvPERL;
  String pvAREL;
  String pvDEPL;
  String pvPUNL;
  String pvPREL;
  String pvEMPL;

  String list3Detalle = '';
  double list3Presupeustado = 0;
  double list3Ejecutado = 0;

  String list2Detalle = '';
  double list2Presupeustado = 0;
  double list2Ejecutado = 0;

  //DEFINICION DE VARIABLES

  double venta = 0;
  double gasto = 0;
  double percent = 0.0;
  var size;

  String _opcionKpi = '1';
  List<String> _comboEscala = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  List<String> _comboMargen = ['1', '2', '3'];
  //List<String> _comboEmpresa = ['1', '2', '3'];

  String _areaEscala = '1';
  String _areaMargen = '1';

  String _dptoEscala = '1';
  String _dptoMargen = '1';

  String _puntualidadEscala = '1';
  String _puntualidadMargen = '1';

  String _ptoEscala = '1';
  String _ptoMargen = '1';

  String _empresaEscala = '1';
  String _empresaMargen = '1';

  String _kpiEscala = '1';
  String _kpiMargen = '1';

  // String _opcionPorcentajeEmpresa = '1';
  // String _opcionPorcentajePersonal = '1';
  // String _opcionPorcentajeDpto = '1';
  // String _opcionPorcentajePpto = '1';
  String valorGeneral = '1';
  String valorGeneralMargen = '1';
  String pers = '-1';
  String ares = '-1';
  String deps = '-1';
  String punts = '-1';
  String pres = '-1';
  String emps = '-1';

  List<String> _comboPorcentaje = ['1', '5', '10', '15', '20'];

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 10000));
    controllerArea.text = '0';
    controllerDepto.text = '0';
    controllerPuntualidad.text = '0';
    controllerPpto.text = '0';
    controllerEmpresa.text = '0';
    controllerKPI.text = '0';
    _initialValue = '0';
    _futureBuilderGeneral(context);
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
        _totalGeneral(context),
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

            sizedBox(0.0, 10.0),
            _notakpiGeneral(context),
            sizedBox(0.0, 10.0),
            //  dividerGreen(),
            sizedBox(0.0, 10.0),
            _notaAreaGeneral(context),
            sizedBox(0.0, 10.0),
            //   dividerGreen(),
            sizedBox(0.0, 10.0),
            _notaDeptoGeneral(context),
            sizedBox(0.0, 10.0),
            //   dividerGreen(),
            sizedBox(0.0, 10.0),
            _notaPuntualidadGeneral(context),
            sizedBox(0.0, 10.0),
            //   dividerGreen(),
            sizedBox(0.0, 10.0),
            _notaPresupuestoGeneral(context),
            sizedBox(0.0, 10.0),
            //   dividerGreen(),
            sizedBox(0.0, 10.0),
            _notaEmpresaGeneral(context),
            // dividerGreen(),
            // sizedBox(0.0, 10.0),

            // copyRigthBlack(),
          ],
        ),
      ),
    );
  }

  _futureBuilderGeneral(BuildContext context) async {
    entityGauge.apiUrl =
        "http://amasventas.neuronatexnology.com/api/GetIndicadores/GetVentasSimulador/usuario/" +
            prefs.nameUser +
            '/PERS/$pers/ARES/$ares/DEPS/$deps/PUNTS/$punts/PRES/$pres/EMPS/$emps';

    List<SimuladorList> lista =
        await new Repository().getDataSimuladorList(entityGauge);
    setState(() {
      list2Detalle = lista[0].list2[0].detalle;
      list2Presupeustado = lista[0].list2[0].presupuestado;
      list2Ejecutado = lista[0].list2[0].ejecutado;

      list3Detalle = lista[0].list3[0].detalle;
      list3Presupeustado = lista[0].list3[0].presupuestado;
      list3Ejecutado = lista[0].list3[0].ejecutado;

      print('Listasssssss: $list3Presupeustado');
      // _initialValue = deps;
      _cargarDatos(lista[0]);
    });
  }

  _cargarDatos(SimuladorList entity) {
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
    empresa = entity.empresa;
    personal = entity.personal;
    valorPresupuesto = entity.pvPRE;
    valorPuntualidad = entity.pvPUN;
    valorDepto = entity.pvDEP;
    valorArea = entity.pvARE;
    valorPersonal = entity.pvEMP;
    porcentajePresupuesto = entity.vdPREPp;
    porcentajePuntualidad = entity.vdPUNPp;
    porcentajeDepto = entity.vdDEPPp;
    porcentajeArea = entity.vdAREPp;
    porcentajePersonal = entity.vdEMPPp;

    pvPERL = entity.pvPERL;
    pvAREL = entity.pvAREL;
    pvDEPL = entity.pvDEPL;
    pvPUNL = entity.pvPUNL;
    pvPREL = entity.pvPREL;
    pvEMPL = entity.pvEMPL;
  }

  // *************************** KPI INICIO *************************************

  Widget _kpi(BuildContext context) {
    print('entro al pvPERL: $pvPERL');
    if (pvPERL == 'ESC') return _comboKpiEscala(context);
    if (pvPERL == 'MAR') return _comboKpiMargen(context);
    if (pvPERL == 'POR') return _textoKpi(context);
  }

  Widget _comboKpiEscala(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione KPI :', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _kpiEscala,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listarComboKpi(),
          onChanged: (value) {
            setState(() {
              _kpiEscala = value;
              pers = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listarComboKpi() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboEscala.forEach((comboEscala) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboEscala,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboEscala,
      ));
    });
    return lista;
  }

  Widget _comboKpiMargen(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione KPI :', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _kpiMargen,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listarKpiMargens(),
          onChanged: (value) {
            setState(() {
              _kpiMargen = value;
              pers = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listarKpiMargens() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboMargen.forEach((comboMargen) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboMargen,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboMargen,
      ));
    });
    return lista;
  }

  Widget _textoKpi(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          TextFormField(
            // controller: controllerArea,
            initialValue: '0',
            expands: false,
            maxLength: 5,
            maxLengthEnforced: true,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              //   icon: Icon(Icons.person),
              hintText: 'Ingrese un valor',
              labelText: 'valor de 0 a 120',
              isCollapsed: false,
            ),
            onChanged: (value) {
              setState(() {
                pers = value;
                //  controllerArea.text = value;
              });
            },
            //   validator: (String value) {
            //  //   return double.parse(value).isNaN ? '' : 'NO es un numero!!!';
            //   },
          ),
        ],
      ),
    );
  }
// **************************************** KPI - FIN  *****************************************

  // *************************** AREA INICIO *************************************

  Widget _area(BuildContext context) {
    print('entro al pvAREL: $pvAREL');
    if (pvAREL == 'ESC') return _comboAreaEscala(context);
    if (pvAREL == 'MAR') return _comboAreaMargen(context);
    if (pvAREL == 'POR') return _textoArea(context);
  }

  Widget _comboAreaEscala(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione Área :', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _areaEscala,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listarComboArea(),
          onChanged: (value) {
            setState(() {
              _areaEscala = value;
              ares = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listarComboArea() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboEscala.forEach((comboEscala) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboEscala,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboEscala,
      ));
    });
    return lista;
  }

  Widget _comboAreaMargen(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione Área :', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _areaMargen,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listarComboMargen(),
          onChanged: (value) {
            setState(() {
              _areaMargen = value;
              ares = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listarComboMargen() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboMargen.forEach((comboMargen) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboMargen,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboMargen,
      ));
    });
    return lista;
  }

  Widget _textoArea(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          TextFormField(
            //controller: ares,
            initialValue: _initialValue,
            expands: false,
            maxLength: 5,
            maxLengthEnforced: true,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              //   icon: Icon(Icons.person),
              hintText: 'Ingrese un valor',
              labelText: 'valor de 0 a 120',
              isCollapsed: false,
            ),
            onChanged: (value) {
              setState(() {
                ares = value.trim();
                controllerArea.text = value;
              });
            },
            // validator: (String value) {
            //   return double.parse(value).isNaN ? '' : 'NO es un numero!!!';
            // },
          ),
        ],
      ),
    );
  }
// **************************************** AREA - FIN  *****************************************

  // **************************************** DEPTO - INICIO  *****************************************

  Widget _dpto(BuildContext context) {
    print('entro al pvDEPL: $pvDEPL');
    if (pvDEPL == 'ESC') return _comboDptoEscala(context);
    if (pvDEPL == 'MAR') return _comboDeptoMargen(context);
    if (pvDEPL == 'POR') return _textoDepto(context);
  }

  Widget _comboDptoEscala(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione Dpto. :', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _dptoEscala,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listarComboDepto(),
          onChanged: (value) {
            setState(() {
              _dptoEscala = value;
              deps = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listarComboDepto() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboEscala.forEach((comboEscala) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboEscala,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboEscala,
      ));
    });
    return lista;
  }

  Widget _comboDeptoMargen(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione Dpto. :', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _dptoMargen,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listaDeptoMargen(),
          onChanged: (value) {
            setState(() {
              _dptoMargen = value;
              deps = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listaDeptoMargen() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboMargen.forEach((comboMargen) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboMargen,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboMargen,
      ));
    });
    return lista;
  }

  Widget _textoDepto(BuildContext context) {
    print('_initialValue:: $_initialValue');
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          TextFormField(
            // controller: controllerArea,
            initialValue: _initialValue,
            //  expands: false,
            maxLength: 5,
            //  maxLengthEnforced: true,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              //   icon: Icon(Icons.person),
              hintText: 'Ingrese un valor',
              labelText: 'valor de 0 a 120',
              //    isCollapsed: false,
            ),
            onChanged: (value) {
              setState(() {
                deps = value;
                // _initialValue = deps;
                //  controllerArea.text = value;
              });
            },
            // validator: (String value) {
            //   // return double.parse(value).isNaN ? '' : 'NO es un numero!!!';
            //   // print('dddd: $value');
            //   // if (value.isEmpty) {
            //   //   return 'Ingrese un valor';
            //   // }

            //   // // if (double.parse(value).isNaN) {
            //   // //   return null;
            //   // // }
            //   //  return null;
            // },
            //   onSaved: (value) => controllerArea.text = value,
          ),
        ],
      ),
    );
  }

  // **************************************** DEPTO - FINNN  *****************************************

  // **************************************** PUNTUALIDD - INICIO  *****************************************

  Widget _puntualidad(BuildContext context) {
    print('entro al pvPUNL: $pvPUNL');
    if (pvPUNL == 'ESC') return _comboPuntualidadEscala(context);
    if (pvPUNL == 'MAR') return _comboPuntualidadMargen(context);
    if (pvPUNL == 'POR') return _textoPuntualidad(context);
  }

  Widget _comboPuntualidadEscala(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione Puntualidad:', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _puntualidadEscala,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listarComboPuntualidad(),
          onChanged: (value) {
            setState(() {
              _puntualidadEscala = value;
              punts = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listarComboPuntualidad() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboEscala.forEach((comboEscala) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboEscala,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboEscala,
      ));
    });
    return lista;
  }

  Widget _comboPuntualidadMargen(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione Puntualidad :', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _puntualidadMargen,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listaPuntualidadMargen(),
          onChanged: (value) {
            setState(() {
              _puntualidadMargen = value;
              punts = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listaPuntualidadMargen() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboMargen.forEach((comboMargen) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboMargen,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboMargen,
      ));
    });
    return lista;
  }

  Widget _textoPuntualidad(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          TextFormField(
            // controller: controllerArea,
            initialValue: '0',
            expands: false,
            maxLength: 5,
            maxLengthEnforced: true,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              //   icon: Icon(Icons.person),
              hintText: 'Ingrese un valor',
              labelText: 'valor de 0 a 120',
              isCollapsed: false,
            ),
            onChanged: (value) {
              setState(() {
                punts = value;
                //  controllerArea.text = value;
              });
            },
            // validator: (String value) {
            //   return double.parse(value).isNaN ? '' : 'NO es un numero!!!';
            // },
          ),
        ],
      ),
    );
  }

  // **************************************** PUNTUALIDAD - FINNN  *****************************************

  // **************************************** PRESUPEUSTO - INICIO  *****************************************

  Widget _ppto(BuildContext context) {
    print('entro al pvPREL: $pvPUNL');
    if (pvPREL == 'ESC') return _comboPptoEscala(context);
    if (pvPREL == 'MAR') return _comboPptoMargen(context);
    if (pvPREL == 'POR') return _textoPpto(context);
  }

  Widget _comboPptoEscala(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione Ppto.:', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _ptoEscala,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listarComboPpto(),
          onChanged: (value) {
            setState(() {
              _ptoEscala = value;
              pres = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listarComboPpto() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboEscala.forEach((comboEscala) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboEscala,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboEscala,
      ));
    });
    return lista;
  }

  Widget _comboPptoMargen(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione Ppto. :', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _ptoMargen,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listaPptoMargen(),
          onChanged: (value) {
            setState(() {
              _ptoMargen = value;
              pres = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listaPptoMargen() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboMargen.forEach((comboMargen) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboMargen,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboMargen,
      ));
    });
    return lista;
  }

  Widget _textoPpto(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          TextFormField(
            // controller: controllerArea,
            initialValue: controllerPpto.text,
            expands: false,
            maxLength: 5,
            maxLengthEnforced: true,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              //   icon: Icon(Icons.person),
              hintText: 'Ingrese un valor',
              labelText: 'valor de 0 a 120',
              isCollapsed: false,
            ),
            onChanged: (value) {
              setState(() {
                pres = value;
                controllerPpto.text = value;
              });
            },
            // validator: (String value) {
            //   return double.parse(value).isNaN ? '' : 'NO es un numero!!!';
            // },
          ),
        ],
      ),
    );
  }

  // **************************************** PRESUPEUSTO - FINNN  *****************************************

// **************************************** EMPRESA - INICIO  *****************************************

  Widget _empresa(BuildContext context) {
    print('entro al pvEMPL: $pvEMPL');
    if (pvEMPL == 'ESC') return _comboEmpEscala(context);
    if (pvEMPL == 'MAR') return _comboEmpMargen(context);
    if (pvEMPL == 'POR') return _textoEmp(context);
  }

  Widget _comboEmpEscala(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione Empresa:', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _empresaEscala,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listarComboEmp(),
          onChanged: (value) {
            setState(() {
              _empresaEscala = value;
              emps = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listarComboEmp() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboEscala.forEach((comboEscala) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboEscala,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboEscala,
      ));
    });
    return lista;
  }

  Widget _comboEmpMargen(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text('Seleccione Empresa :', style: TextStyle(fontSize: 19)),
        SizedBox(width: 5.0),
        DropdownButton(
          value: _empresaMargen,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeGreen),
          items: _listaEmpMargen(),
          onChanged: (value) {
            setState(() {
              _empresaMargen = value;
              emps = value;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _listaEmpMargen() {
    List<DropdownMenuItem<String>> lista = new List();

    _comboMargen.forEach((comboMargen) {
      lista.add(DropdownMenuItem(
        child: Text(
          comboMargen,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        value: comboMargen,
      ));
    });
    return lista;
  }

  Widget _textoEmp(BuildContext context) {
    sizedBox(25, 0);
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          TextFormField(
            // controller: controllerArea,
            initialValue: '0',
            expands: false,
            maxLength: 5,
            maxLengthEnforced: true,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              //   icon: Icon(Icons.person),
              hintText: 'Ingrese un valor',
              labelText: 'valor de 0 a 120',
              isCollapsed: false,
            ),
            onChanged: (value) {
              setState(() {
                emps = value;
                //  controllerArea.text = value;
              });
            },
            // validator: (String value) {
            //   return double.parse(value).isNaN ? '' : 'NO es un numero!!!';
            // },
          ),
        ],
      ),
    );
  }

  // **************************************** EMPRESA - FINNN  *****************************************

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
                  sizedBox(5, 0.0),
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
                                fontSize: 16,
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
        //  _textoArea(context),
        _cabeceraGeneral(
            '$area', '${porcentajeArea.toString()}', AppTheme.themeGreen),
        //  _textoArea(context),
        sizedBox(15, 0),
        Row(
          children: [
            sizedBox(15, 0),
            InkWell(
              onTap: () {
                setState(() {
                  _areaMargen = '1';
                  _areaEscala = '1';
                  ares = '-1';
                  _initialValue = '0';
                  controllerArea.text = '0';
                  _futureBuilderGeneral(context);
                  //  controllerArea.text = value;
                });
              },
              child: FaIcon(
                FontAwesomeIcons.clipboard,
                color: AppTheme.themeGreen,
                size: 35,
              ),
            ),
            sizedBox(15, 0),
            InkWell(
              onTap: () {
                _futureBuilderGeneral(context);
              },
              child: FaIcon(
                FontAwesomeIcons.sync,
                color: AppTheme.themeGreen,
                size: 35,
              ),
            ),

            sizedBox(15, 0),
            _area(context),
            // sizedBox(45, 0),
            // sizedBox(10, 0),
          ],
        ),

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
              ],
            ),
            AppTheme.themeWhite,
            AppTheme.themeWhite,
            false),

        //  _futureBuilderBarras(context),
        _notaSubtotal(context, vdkpiare.toString(), moneda),
      ]);
    } else
      return Container();
  }

  Widget _notaDeptoGeneral(BuildContext context) {
    if (valorDepto == 'S') {
      return Column(children: [
        _cabeceraGeneral(
            '$depto', '${porcentajeDepto.toString()}', AppTheme.themeGreen),
        sizedBox(15, 0),
        Row(
          children: [
            sizedBox(15, 0),
            InkWell(
              onTap: () {
                setState(() {
                  _dptoMargen = '1';
                  _dptoEscala = '1';
                  deps = '-1';
                  //  _textoDepto(context);
                  _futureBuilderGeneral(context);
                });

                setState(() {});
              },
              child: FaIcon(
                FontAwesomeIcons.clipboard,
                color: AppTheme.themeGreen,
                size: 35,
              ),
            ),
            sizedBox(15, 0),
            InkWell(
              onTap: () {
                // if (!formKey.currentState.validate()) return;
                // formKey.currentState.save();
                _futureBuilderGeneral(context);
              },
              child: FaIcon(
                FontAwesomeIcons.sync,
                color: AppTheme.themeGreen,
                size: 35,
              ),
            ),

            sizedBox(15, 0),
            _dpto(context),

            // sizedBox(45, 0),
            // sizedBox(10, 0),
          ],
        ),
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

  Widget _notaPuntualidadGeneral(BuildContext context) {
    if (valorPuntualidad == 'S') {
      return Column(children: [
        _cabeceraGeneral('$puntualidad', '${porcentajePuntualidad.toString()}',
            AppTheme.themeGreen),
        sizedBox(15, 0),
        Row(
          children: [
            sizedBox(15, 0),
            InkWell(
              onTap: () {
                _puntualidadMargen = '1';
                _puntualidadEscala = '1';
                punts = '-1';
                _initialValue = '0';
                controllerPuntualidad.text = '0';
                _futureBuilderGeneral(context);
              },
              child: FaIcon(
                FontAwesomeIcons.clipboard,
                color: AppTheme.themeGreen,
                size: 35,
              ),
            ),
            sizedBox(15, 0),
            InkWell(
              onTap: () {
                _futureBuilderGeneral(context);
              },
              child: FaIcon(
                FontAwesomeIcons.sync,
                color: AppTheme.themeGreen,
                size: 35,
              ),
            ),

            sizedBox(12, 0),
            _puntualidad(context),
            // sizedBox(45, 0),
            // sizedBox(10, 0),
          ],
        ),
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

  Widget _notaPresupuestoGeneral(BuildContext context) {
    print('ENTRO A RPESUPUESTO: $valorPresupuesto');

    if (valorPresupuesto == 'S') {
      return Column(children: [
        _cabeceraGeneral('$presupuesto', '${porcentajePresupuesto.toString()}',
            AppTheme.themeGreen),
        sizedBox(15, 0),
        Row(
          children: [
            sizedBox(15, 0),
            InkWell(
              onTap: () {
                _ptoMargen = '1';
                _ptoEscala = '1';
                pres = '-1';
                _initialValue = '0';
                controllerPpto.text = '0';
                _futureBuilderGeneral(context);
              },
              child: FaIcon(
                FontAwesomeIcons.clipboard,
                color: AppTheme.themeGreen,
                size: 35,
              ),
            ),
            sizedBox(15, 0),
            InkWell(
              onTap: () {
                _futureBuilderGeneral(context);
              },
              child: FaIcon(
                FontAwesomeIcons.sync,
                color: AppTheme.themeGreen,
                size: 35,
              ),
            ),
            sizedBox(12, 0),
            _ppto(context),
          ],
        ),
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

  Widget _notaEmpresaGeneral(BuildContext context) {
    if (valorPersonal == 'S') {
      return Column(children: [
        _cabeceraGeneral('$empresa', '${porcentajePersonal.toString()}',
            AppTheme.themeGreen),
        Row(
          children: [
            sizedBox(15, 0),
            InkWell(
              onTap: () {
                _empresaMargen = '1';
                _empresaEscala = '1';
                emps = '-1';
                _initialValue = '0';
                controllerEmpresa.text = '0';
                _futureBuilderGeneral(context);
              },
              child: FaIcon(
                FontAwesomeIcons.clipboard,
                color: AppTheme.themeGreen,
                size: 35,
              ),
            ),
            sizedBox(15, 0),
            InkWell(
              onTap: () {
                _futureBuilderGeneral(context);
              },
              child: FaIcon(
                FontAwesomeIcons.sync,
                color: AppTheme.themeGreen,
                size: 35,
              ),
            ),
            sizedBox(14, 0),
            _empresa(context),
          ],
        ),
        _futureBuilderBarras(context),
        _notaSubtotal(context, vdkpiemp.toString(), moneda),
      ]);
    } else
      return Container();
  }

  Widget _notakpiGeneral(BuildContext context) {
    return Column(children: [
      _neutro('$personal'),
      sizedBox(15, 0),
      Row(
        children: [
          sizedBox(15, 0),
          InkWell(
            onTap: () {
              _kpiMargen = '1';
              _kpiEscala = '1';
              pers = '-1';
              _initialValue = '0';
              controllerKPI.text = '0';
              _futureBuilderGeneral(context);
            },
            child: FaIcon(
              FontAwesomeIcons.clipboard,
              color: AppTheme.themeGreen,
              size: 35,
            ),
          ),
          sizedBox(15, 0),
          InkWell(
            onTap: () {
              _futureBuilderGeneral(context);
            },
            child: FaIcon(
              FontAwesomeIcons.sync,
              color: AppTheme.themeGreen,
              size: 35,
            ),
          ),
          sizedBox(15, 0),
          _kpi(context),
        ],
      ),
      _futureBuilderList(context),
      _notaKPI(context),
    ]);
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
        SimuladorList entity = snapshot.data[index];
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
                      sizedBox(10.0, 5.0),
                      Text("VALORACIÓN        PONDERACIÓN",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () {
                          _futureBuilderGeneral(context);
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
                  sizedBox(8, 0),
                  Image.network(
                    urlEstrella,
                    height: 45,
                    width: 45,
                  ),
                  sizedBox(10, 0),
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
                  sizedBox(170, 0.0),
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
