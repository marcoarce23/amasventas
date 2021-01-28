import 'package:amasventas/src/data/entity/EntityFromJson/EscalasList.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:amasventas/src/widget/Dashboard/Gauges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:getwidget/getwidget.dart';

class SimuladorAllPage extends StatefulWidget {
  static final String routeName = 'simuladorAll';
  const SimuladorAllPage({Key key}) : super(key: key);

  @override
  _SimuladorAllPageState createState() => _SimuladorAllPageState();
}

class _SimuladorAllPageState extends State<SimuladorAllPage> {
  int page = 1;
  final prefs = new Preferense();
String typeCount = 'ENE';
  List<String> _cantidad = [
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
  final List<Widget> optionPage = [
    HomePage(),
    SimuladorPage(),
    SimuladorDetallePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = SimuladorAllPage.routeName;
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
              title: Text('Mi Simulador')),
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

class SimuladorPage extends StatefulWidget {
  static final String routeName = 'ventas';

  @override
  _SimuladorPageState createState() => _SimuladorPageState();
}

class _SimuladorPageState extends State<SimuladorPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = new Preferense();
  final montoController = TextEditingController();
  bool _save = false;
  String _opcionEscala = '1';
  EscalaList entity = new EscalaList();
  Repository repo = new Repository();

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
          _form(context),
        ],
      ),
      // floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
      //     FaIcon(FontAwesomeIcons.futbol), HomePage()),
    );
  }

  Widget _form(BuildContext context) {
    final size = MediaQuery.of(context).size;
    entity.apiUrl = 'http://amasventas.neuronatexnology.com/api/Escala/GetEscalaComisionTotal';

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          child: Column(
            children: <Widget>[
              sizedBox(0.0, 8.0),
              showInformationBasic(
                context,
                'Bienvenido Gustavo Zalles!!',
                'Progreso de ventas: 5000.00 Bs',
              ),
              sizedBox(0.0, 8.0),
             
              Container(
                width: size.width * 0.94,
                height: 400,
                decoration: containerFileds(),
                //   child: _fields(context),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Objetivo del MEs:'),
                        Text('3455 '),
                      ],
                    ),
                    GaugeColor(),
                    sizedBox(0.0, 8.0),
                     Container(
                width: size.width * 0.94,
                decoration: containerFileds(),
                child: Column(
                  children: [
                    Text('Tu bono es el siguiente:'),
                    Text('200.00 SuS.'),
                  ],
                ),
              ),
                  ],
                ),
              ),
               _comboBox('Escala'),
              _text(
                  montoController,
                  '0',
                  'Ingrese el monto en dolares',
                  6,
                  'Ingrese el monto en dólares',
                  true,
                  FaIcon(FontAwesomeIcons.userCircle,
                      color: AppTheme.themeGrey),
                  AppTheme.themeDefault,
                  AppTheme.themeDefault,
                  Colors.red),
              _button('Generar', 18.0, 20.0),
              sizedBox(0.0, 8.0),

              copyRigthBlack(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _text(
      TextEditingController controller,
      String initialValue,
      String labelText,
      int maxLength,
      String hintText,
      bool isValidate,
      FaIcon icon,
      Color hoverColor,
      Color fillColor,
      Color focusColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: TextFormField(
        initialValue: initialValue,
        textCapitalization: TextCapitalization.sentences,
        enableSuggestions: true,
        maxLength: maxLength,
        autocorrect: true,
        autovalidate: false,
        cursorColor: AppTheme.themeDefault,
        toolbarOptions:
            ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
        keyboardType: TextInputType.text,
        decoration: inputDecoration(
            hintText, labelText, icon, hoverColor, fillColor, focusColor),
        onChanged: (value) {
          setState(() {
            controller.text = value;
          });
        },
        // validator: (value) =>
        //     validator.validateTextfieldEmpty(value, isValidate),
        onSaved: (value) => controller.text = value,
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      EscalaList item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombreEscala),
        value: item.codEscala.toString(),
      ));
    }
    return lista;
  }

  Widget _comboBox(String label) {
    return Center(
        child: FutureBuilder(
            future: repo.getData(entity),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text(label),
                    SizedBox(width: 15.0),
                    DropdownButton(
                     // style: TextStyle(fontSize: 14),
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeGrey),
                      value: _opcionEscala,
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionEscala = value;
                        });
                      },
                    ),
                  ],
                );
              } else {
                return GFLoader(type: GFLoaderType.circle, size: 35.0);
              }
            }));
  }

  Widget _button(String text, double fontSize, double edgeInsets) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: edgeInsets),
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeDefault,
      icon: FaIcon(FontAwesomeIcons.checkCircle, color: AppTheme.themeWhite),
      shape: GFButtonShape.pills,
      onPressed: (_save) ? null : _submit,
    );
  }

  _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    print('myControllerSOY EL VALOR DE ' + montoController.text);

    setState(() => _save = true);
    loadingEntity();
    executeCUD();
    setState(() => _save = false);
  }

  void loadingEntity() {
    print('EL RESULAAAAA');
    // entity.idNotificacion =
    //     (entity.states == StateEntity.Insert) ? 0 : entity.idNotificacion;
    // entity.idOrganizacion = 1;
    // // entity.titulo = controllerTitulo.text;
    // // entity.detalle = controllerDetalle.text;
    // entity.usuarioAuditoria = 'prefs.email';
    // entity.foto = IMAGE_LOGO;
    // // entity.fechaAuditoria = '2020-08-10 08:25';
    // print('EL RESULAAAAA ${entity.titulo}');
    // print('EL RESULAAAAA ${entity.detalle}');
  }

  void executeCUD() async {
    print('EL RESULAAccccA');

    // Future<dynamic> response = RepositoryNotify().add(entity);
    // await responseMessageService(response, scaffoldKey);

/*
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0')
          showSnackbar(STATUS_OK, scaffoldKey);
        else
          showSnackbar(STATUS_ERROR, scaffoldKey);
          */
  }
}

class SimuladorDetallePage extends StatefulWidget {
  static final String routeName = 'ventas';

  @override
  _SimuladorDetallePageState createState() => _SimuladorDetallePageState();
}

class _SimuladorDetallePageState extends State<SimuladorDetallePage> {
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
                'Progreso de ventas: 5000.00 Bs',
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
                    GaugeColor(),
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
                    Text('Tu bono Cump. PPTo.:'),
                    Text('400.00 SuS.'),
                    Text('El resultado: Atención'),
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
