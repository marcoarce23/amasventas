import 'dart:io';
import 'package:amasventas/src/crosscutting/StatusCode.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/page/notification/NotificationPage.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:amasventas/src/data/entity/EntityMap/NotificationModel.dart';
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

class NotificationAllPage extends StatefulWidget {
  static final String routeName = 'notificationAll';
  const NotificationAllPage({Key key}) : super(key: key);

  @override
  _NotificationAllPageState createState() => _NotificationAllPageState();
}

class _NotificationAllPageState extends State<NotificationAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [NotificationLoadPage(), NotificationPage()];

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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 21.0,
        backgroundColor: AppTheme.themeGreen,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.newspaper,
                  size: 25, color: Colors.white),
              title: Text('Nuevo')),
          BottomNavigationBarItem(
              icon:
                  FaIcon(FontAwesomeIcons.bell, size: 25, color: Colors.white),
              title: Text('Notificaciones')),
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
  NotificacionModel entity = new NotificacionModel();
  // gets.NotificacionModel entityGet = new gets.NotificacionModel();

  final prefs = new Preferense();

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
    // final gets.NotificacionModel entityModelGet =
    //     ModalRoute.of(context).settings.arguments;

    // if (entityModelGet != null) {
    //   entity.detalle = entityModelGet.detalle;
    //   entity.titulo = entityModelGet.titulo;
    //   entity.idNotificacion = entityModelGet.idNotificacion;
    //   entity.states = StateEntity.Update;
    //   print(entityModelGet.detalle);
    // }

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('NOTIFICACIONES'),
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
                'GESTIONA LAS NOTIFICACIONES',
                'En la pantalla podrás crear y modficar las notificaciones.\nLos campos con (*) son obligatorios.',
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
            controllerTitulo,
            entity.titulo,
            '(*) Notificación',
            100,
            2,
            'Ingrese la notificación',
            true,
            FaIcon(FontAwesomeIcons.newspaper, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerDetalle,
            entity.detalle,
            '(*) Detalle de la notificación',
            140,
            3,
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
    entity.apiUrl = "http://virtualmatch.neuronatexnology.com/api/Notificacion";
    entity.idNotificacion =
        (entity.states == StateEntity.Insert) ? 0 : entity.idNotificacion;
    entity.idOrganizacion = 1;
    entity.titulo = controllerTitulo.text;
    entity.detalle = controllerDetalle.text;
    entity.usuarioAuditoria = 'amasventas';
    entity.foto = IMAGE_LOGO;
  }

  void executeCUD(NotificacionModel entity) async {
    try {
      await new Repository().add(entity).then((result) {
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
