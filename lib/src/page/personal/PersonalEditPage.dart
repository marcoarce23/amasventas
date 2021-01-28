import 'dart:io';
import 'package:amasventas/src/crosscutting/StatusCode.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/DominioList.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/PersonaList.dart';
import 'package:amasventas/src/data/entity/EntityMap/PersonalModel.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/page/personal/PersonalListPage.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/image/ImageWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:amasventas/src/crosscutting/Validator.dart' as validator;

class PersonalAllPage extends StatefulWidget {
  static final String routeName = 'personal';
  const PersonalAllPage({Key key}) : super(key: key);

  @override
  _PersonalAllPageState createState() => _PersonalAllPageState();
}

class _PersonalAllPageState extends State<PersonalAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [PersonalEditPage(), PersonalListPage()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = PersonalAllPage.routeName;
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
              icon: FaIcon(FontAwesomeIcons.userEdit,
                  size: 25, color: Colors.white),
              title: Text('Editar')),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userCheck,
                  size: 25, color: Colors.white),
              title: Text('Ver Perfil')),
        ],
        currentIndex: page,
        unselectedItemColor: AppTheme.themeWhite,
        selectedItemColor: AppTheme.themeBlackBlack,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
      //),
    );
  }
}

class PersonalEditPage extends StatefulWidget {
  static final String routeName = 'personalEdit';

  @override
  _PersonalEditPageState createState() => _PersonalEditPageState();
}

class _PersonalEditPageState extends State<PersonalEditPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controllerNombre = TextEditingController();
  final controllerPaterno = TextEditingController();
  final controllerMaterno = TextEditingController();
  final controllerCi = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerCelular = TextEditingController();
//DEFINICION DE BLOC Y MODEL
  PersonalModel entity = new PersonalModel();
  SucursalList entitySucursalGet = new SucursalList();
  JefeInmediatoList entityJefeGet = new JefeInmediatoList();
  DptoAreaList entityDptoGet = new DptoAreaList();
  CargoList entityCargoGet = new CargoList();

  final prefs = new Preferense();
  String _opcionSucursal = 'CIJZ80001';
  String _opcionJefeInmediato = 'ADM';
  String _opcionDeptoArea = '2';
  String _opcionCargo = 'Cargo 1';

  //DEFINICION DE VARIABLES
  bool _save = false;
  File photo;

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    entity.states = StateEntity.Insert;
    entity.tipoOperacion = 'C';
    final PersonaList entityModelGet =
        ModalRoute.of(context).settings.arguments;

    if (entityModelGet != null) {
      entity.nombre = entityModelGet.nombreCompleto;
      entity.paterno = entityModelGet.apellidoPaterno;
      entity.materno = entityModelGet.apellidoMaterno;
      entity.celular = entityModelGet.celular;
      entity.email = entityModelGet.email;
      entity.nroDocumento = entityModelGet.nroDocumento;
      _opcionSucursal = entityModelGet.cod_sucursal;
      _opcionJefeInmediato = entityModelGet.cod_jefe_inmediato;
      _opcionDeptoArea = entityModelGet.cod_area.toString();
      _opcionCargo = entityModelGet.cod_cargo;
      print(entity.nombre);
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('EDITAR PERFIL'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          _form(context),
        ],
      ),
      floatingActionButton: floatButton(AppTheme.themeGreen, context,
          FaIcon(FontAwesomeIcons.plane), HomePage()),
    );
  }

  Widget _form(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          child: Column(
            children: <Widget>[
              sizedBox(0.0, 8.0),
              showInformationBasic(
                context,
                'GESTIONA TU PERFIL',
                'En la pantalla podrás editar de personal.\nLos campos con (*) son obligatorios.',
              ),
              sizedBox(0.0, 10.0),
              Container(
                width: size.width * 0.94,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                decoration: containerFileds(),
                child: _fields(context),
              ),
              copyRigthBlack(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        showPictureOval(photo, IMAGE_LOGON, 0.0),
        dividerGreen(),
        _text(
            controllerNombre,
            entity.nombre,
            '(*) Nombre completo',
            100,
            1,
            'Ingrese la notificación',
            true,
            FaIcon(FontAwesomeIcons.user, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerPaterno,
            entity.paterno,
            '(*) Apellido Paterno',
            100,
            1,
            'Ingrese Apellido Paterno',
            true,
            FaIcon(FontAwesomeIcons.userAlt, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerMaterno,
            entity.materno,
            '(*) Apellido Materno',
            100,
            1,
            'Ingrese Apellido Materno',
            true,
            FaIcon(FontAwesomeIcons.userEdit, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerCi,
            entity.nroDocumento,
            '(*) Número de documento',
            20,
            1,
            'Ingrese número de documento',
            true,
            FaIcon(FontAwesomeIcons.addressCard, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerCelular,
            entity.celular,
            '(*) Celular de Contacto',
            10,
            1,
            'Ingrese Número de celular',
            true,
            FaIcon(FontAwesomeIcons.tabletAlt, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerEmail,
            entity.email,
            '(*) Correo Electrónico',
            100,
            1,
            'Ingrese correo electrónico',
            true,
            FaIcon(FontAwesomeIcons.mailBulk, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _comboBoxSucursal(''),
        _comboBoxSJefeInmediato(''),
        _comboBoxDeptoArea(''),
        _comboBoxCargo(
          '',
        ),
        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),
        _button('Guardar', 18.0, 20.0),
      ],
    );
  }

  List<DropdownMenuItem<String>> getDropDownSucursal(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      SucursalList item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombreSucursal),
        value: item.codSucursal.toString(),
      ));
    }
    return lista;
  }

  List<DropdownMenuItem<String>> getDropDownJefe(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      JefeInmediatoList item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.usuario.toString(),
      ));
    }
    return lista;
  }

  List<DropdownMenuItem<String>> getDropDownDptoArea(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      DptoAreaList item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.area),
        value: item.idOrganigrama.toString(),
      ));
    }
    return lista;
  }

  List<DropdownMenuItem<String>> getDropDownCargo(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      CargoList item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.descripcion),
        value: item.codigo.toString(),
      ));
    }
    return lista;
  }

  Widget _comboBoxSucursal(String label) {
    entitySucursalGet.apiUrl =
        "http://amasventas.neuronatexnology.com/api/Parametrica/GetSucursalTotal";

    return Center(
        child: FutureBuilder(
            future: new Repository().getData(entitySucursalGet),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 2.0),
                    Text(label),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeGreen),
                      value: _opcionSucursal,
                      items: getDropDownSucursal(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionSucursal = value;
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

  Widget _comboBoxSJefeInmediato(String label) {
    entityJefeGet.apiUrl =
        "http://amasventas.neuronatexnology.com/api/Parametrica/GetJefeInmediatoLista";

    return Center(
        child: FutureBuilder(
            future: new Repository().getData(entityJefeGet),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 2.0),
                    Text(label),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeGreen),
                      value: _opcionJefeInmediato,
                      items: getDropDownJefe(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionJefeInmediato = value;
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

  Widget _comboBoxDeptoArea(String label) {
    entityDptoGet.apiUrl =
        "http://amasventas.neuronatexnology.com/api/Parametrica/GetObtieneDptoAreaLista";
    return Center(
        child: FutureBuilder(
            future: new Repository().getData(entityDptoGet),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 2.0),
                    Text(label),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeGreen),
                      value: _opcionDeptoArea,
                      items: getDropDownDptoArea(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionDeptoArea = value;
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

  Widget _comboBoxCargo(String label) {
    entityCargoGet.apiUrl =
        "http://amasventas.neuronatexnology.com/api/Parametrica/GetDominiosCargo";
    return Center(
        child: FutureBuilder(
            future: new Repository().getData(entityCargoGet),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 2.0),
                    Text(label),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeGreen),
                      value: _opcionCargo,
                      items: getDropDownCargo(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionCargo = value;
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

  Widget _text(
      TextEditingController controller,
      String initialValue,
      String labelText,
      int maxLength,
      int maxLines,
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
        maxLines: maxLines,
        cursorColor: AppTheme.themeDefault,
        toolbarOptions:
            ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
        keyboardType: TextInputType.text,
        // controller: controller,
        decoration: inputDecoration(
            hintText, labelText, icon, hoverColor, fillColor, focusColor),
        onChanged: (value) {
          setState(() {
            controller.text = value;
          });
        },
        validator: (value) =>
            validator.validateTextfieldEmpty(value, isValidate),
        onSaved: (value) => controller.text = value,
      ),
    );
  }

  Widget _button(String text, double fontSize, double edgeInsets) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: edgeInsets),
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeGreen,
      icon: FaIcon(FontAwesomeIcons.checkCircle, color: AppTheme.themeWhite),
      shape: GFButtonShape.pills,
      onPressed: (_save) ? null : _submit,
    );
  }

  _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() => _save = true);
    loadingEntity();
    executeCUD(entity);
    setState(() => _save = false);
  }

  void loadingEntity() {
    entity.apiUrl = "http://amasventas.neuronatexnology.com/api/Abm/usuario";
    entity.nombre = controllerNombre.text;
    entity.paterno = controllerPaterno.text;
    entity.materno = controllerMaterno.text;
    entity.celular = '0';
    entity.email = controllerEmail.text;
    entity.nroDocumento = controllerCi.text;
    entity.usuario = prefs.nameUser;
    entity.usuarioReg = 'adm';
    entity.password = '0';
    entity.web = '0';
    entity.mobile = '0';
    entity.fechaDesde = '01/01/2020';
    entity.fechaHasta = '01/01/2021';
    entity.codSucursal = _opcionSucursal;
    entity.tipoDoc = '0';
    entity.tipo = '0';
    entity.motivo = '0';
    entity.amadeus = '0';
    entity.uid = '0';
    entity.jefe = _opcionJefeInmediato;
    entity.areadepto = int.parse(_opcionDeptoArea);
    entity.cargo = _opcionCargo;
    entity.telefono = controllerCelular.text;
    entity.sueldo = 0;
  }

  void executeCUD(PersonalModel entity) async {
    try {
      await new Repository().add(entity).then((result) {
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }
}
