import 'dart:io';
import 'package:amasventas/src/crosscutting/StatusCode.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/DominioList.dart';
import 'package:amasventas/src/data/entity/EntityMap/CambiarPasswordModel.dart';
import 'package:amasventas/src/data/entity/EntityMap/ResetPasswordModel.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/page/intro/IntroPage.dart';
import 'package:amasventas/src/page/login/LogOnPage.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:amasventas/src/repository/route/LogOnApi.dart';
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

class RegisterUserPage extends StatefulWidget {
  static final String routeName = 'changePassword';

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controllerEmail = TextEditingController();
  final controllerCI = TextEditingController();
  String _opcionExpedido = 'SCZ';

//DEFINICION DE BLOC Y MODEL

  CambiarPasswordModel entity = new CambiarPasswordModel();
  ResetPasswordModel entity1 = new ResetPasswordModel();
  DominioList entityGet = new DominioList();

  final prefs = new Preferense();

  //DEFINICION DE VARIABLES
  bool _save = false;
  File photo;

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
//sssss
  @override
  Widget build(BuildContext context) {
    entity.states = StateEntity.Insert;
    entity.apiUrl = LogOnApi().apiPassword();

    entity1.states = StateEntity.Insert;
    entity1.apiUrl = LogOnApi().apiReset();

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('NUEVO USUARIO'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGON'),
          //  showPictureOval(photo, image, 130.0),
          _form(context),
        ],
      ),
      floatingActionButton: floatButton(AppTheme.themeGreen, context,
          FaIcon(FontAwesomeIcons.arrowLeft), LogOnPage()),
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
                'Registrate en el sistema',
                'Puedes registrarte y formar parte de la familia Amaszonas.\nLos campos con (*) son obligatorios.',
              ),
              sizedBox(0.0, 5.0),
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
        // Text(
        //   'Usuario autentificado: ${prefs.nameUser}',
        //   style: kSubtitleStyle,
        //   softWrap: true,
        //   overflow: TextOverflow.clip,
        //   textAlign: TextAlign.justify,
        // ),

        _text(
            controllerEmail,
            '',
            '(*) Correo electrónico',
            40,
            1,
            'Ingrese  su correo electrónico',
            true,
            FaIcon(FontAwesomeIcons.mailBulk, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _textCI(
            controllerCI,
            '',
            '(*) Carnet de Identidad',
            10,
            1,
            'Ingrese su carnet de identidad',
            true,
            FaIcon(FontAwesomeIcons.wpforms, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _comboBoxCI('Expedido en:'),

        //  _comboBox('Tipo.', myController.text),
        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),
        _button('Registrar', 18.0, 20.0),
      //  _buttonReset('Resetear', 18.0, 20.0),
      ],
    );
  }

  List<DropdownMenuItem<String>> getDropDownCI(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      DominioList item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.descripcion),
        value: item.codigo.toString(),
      ));
    }
    return lista;
  }

  Widget _comboBoxCI(String label) {
    entityGet.apiUrl =
        "http://amasventas.neuronatexnology.com/api/Parametrica/GetDominios/" +
            "expedido";
    return Center(
        child: FutureBuilder(
            future: new Repository().getData(entityGet),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 15.0),
                     FaIcon(FontAwesomeIcons.mapPin, color: AppTheme.themeDefault),
                     SizedBox(width: 15.0),
                    Text(label),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeGreen),
                      value: _opcionExpedido,
                      items: getDropDownCI(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionExpedido = value;
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
        keyboardType: TextInputType.emailAddress,
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

  Widget _textCI(
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
        keyboardType: TextInputType.phone,
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

  Widget _buttonReset(String text, double fontSize, double edgeInsets) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: edgeInsets),
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeGreen,
      icon: FaIcon(FontAwesomeIcons.checkCircle, color: AppTheme.themeWhite),
      shape: GFButtonShape.pills,
      onPressed: (_save) ? null : _submitReset,
    );
  }

  _submitReset() async {
    // if (!formKey.currentState.validate()) return;
    //  formKey.currentState.save();

    setState(() => _save = true);
    loadingEntity1();
    executeCUD1(entity1);
    setState(() => _save = false);
  }

  void loadingEntity() {
    entity.usuario = prefs.nameUser;
    entity.password = controllerEmail.text;
    entity.nuevopassword = controllerCI.text;

    print('EL RESULAAAAA ${entity.apiUrl}');
  }

  void loadingEntity1() {
    entity1.usuario = prefs.nameUser;
    entity1.coidgoUid = '3b6d36b80ee88022';
    //prefs.userId;

    print('EL RESULAAAAA ${entity1.apiUrl}');
  }

  _submit() async {
    // if (!formKey.currentState.validate()) return;
    //  formKey.currentState.save();

    setState(() => _save = true);
    loadingEntity();
    executeCUD(entity);
    setState(() => _save = false);
  }

  void executeCUD(CambiarPasswordModel entity) async {
    print('EL RESULAAccccA');

    Repository().add(entity).then((result) {
      if (result["tipo_mensaje"] == "0") {
        prefs.nameUser = entity.usuario;
        navegation(context, IntroPage());
      } else
        showSnackbar(STATUS_ERROR, scaffoldKey);
    });

    //  await responseMessageService(response, scaffoldKey);
  }

  void executeCUD1(ResetPasswordModel entity) async {
    print('EL RESETEOOOO');

    Repository().add(entity).then((result1) {
      if (result1["tipo_mensaje"] == "0") {
        // prefs.nameUser = entity.usuario;
        navegation(context, IntroPage());
      } else
        showSnackbar(STATUS_ERROR, scaffoldKey);
    });

    //  await responseMessageService(response, scaffoldKey);
  }
}
