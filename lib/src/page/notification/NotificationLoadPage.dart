import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:amasventas/src/bloc/NotificationBloc.dart';
import 'package:amasventas/src/crosscutting/StatusCode.dart';
import 'package:amasventas/src/data/entity/EntityMap/NotificationModel.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/image/ImageWidget.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:amasventas/src/crosscutting/Validator.dart' as validator;

class NotificationAllPage extends StatefulWidget {
  static final String routeName = 'notificationAll';
  const NotificationAllPage({Key key}) : super(key: key);

  @override
  _NotificationAllPageState createState() => _NotificationAllPageState();
}

class _NotificationAllPageState extends State<NotificationAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = NotificationAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(builder: (_) => new NotificationService()),
    //   ],
    //   child:
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 21.0,
        backgroundColor: AppTheme.themeDefault,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.bell,
                size: 25,
              ),
              title: Text('Notificaciones')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.listAlt,
                size: 25,
              ),
              title: Text('Listado Notificación')),
        ],
        currentIndex: page,
        unselectedItemColor: AppTheme.themeWhite,
        selectedItemColor: AppTheme.themePurple,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
      //),
    );
  }
}

class NotificationLoadPage extends StatefulWidget {
  static final String routeName = 'notificationLoad';

  @override
  _NotificationLoadPageState createState() => _NotificationLoadPageState();
}

class _NotificationLoadPageState extends State<NotificationLoadPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controllerTitulo = TextEditingController();
  final controllerDetalle = TextEditingController();

//DEFINICION DE BLOC Y MODEL
  NotificationBloc entityBloc;
  NotificacionModel entity = new NotificacionModel();
  final prefs = new Preferense();

  //DEFINICION DE VARIABLES
  bool _save = false;
  File photo;

  @override
  void initState() {
    super.initState();
    entityBloc = new NotificationBloc();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
//sssss
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('NOTIFICACIONES'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          //  showPictureOval(photo, image, 130.0),
          _form(context),
        ],
      ),
      floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.futbol), HomePage()),
    );
  }

  Widget _form(BuildContext context) {
    final size = MediaQuery.of(context).size;
    entity.states = StateEntity.Insert;
    entity.apiUrl = API + '/api/Notificacion';

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
                'GESTIONA LAS NOTIFICACIONESa',
                'En la pantalla podrás crear y modficar las notificaciones.\nLos campos con (*) son obligatorios.',
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
        showPictureOval(photo, IMAGE_DEFAULT, 0.0),
        dividerBlack(),
        _text(
            controllerTitulo,
            'entity.titulo',
            '(*) Notificación',
            100,
            3,
            'Ingrese la notificación',
            true,
            FaIcon(FontAwesomeIcons.newspaper, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerDetalle,
            'entity.detalle',
            '(*) Detalle de la notificación',
            140,
            4,
            'Ingrese Detalle de la notificación',
            true,
            FaIcon(FontAwesomeIcons.wpforms, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        //  _comboBox('Tipo.', myController.text),
        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),

        _button('Guardar', 18.0, 20.0),
      ],
    );
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
      color: AppTheme.themeDefault,
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
    executeCUD(entityBloc, entity);
    setState(() => _save = false);
  }

  void loadingEntity() {
    print('EL RESULAAAAA');
    entity.idNotificacion =
        (entity.states == StateEntity.Insert) ? 0 : entity.idNotificacion;
    entity.idOrganizacion = 1;
    entity.titulo = controllerTitulo.text;
    entity.detalle = controllerDetalle.text;
    entity.usuarioAuditoria = 'prefs.email';
    entity.foto = IMAGE_LOGO;
    entity.fechaAuditoria = '2020-08-10 08:25';
    print('EL RESULAAAAA ${entity.titulo}');
    print('EL RESULAAAAA ${entity.detalle}');
  }

  void executeCUD(NotificationBloc entityBloc, NotificacionModel entity) async {
    print('EL RESULAAccccA');

    try {
      await entityBloc.add(entity).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0')
          showSnackbar(STATUS_OK, scaffoldKey);
        else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }
}
