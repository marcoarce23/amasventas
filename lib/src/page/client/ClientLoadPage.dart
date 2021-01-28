import 'dart:io';

import 'package:amasventas/src/data/entity/EntityFromJson/ClasificadorModel.dart';
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
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:amasventas/src/crosscutting/Validator.dart' as validator;

class ClientAllPage extends StatefulWidget {
  static final String routeName = 'client';
  const ClientAllPage({Key key}) : super(key: key);

  @override
  _ClientAllPageState createState() => _ClientAllPageState();
}

class _ClientAllPageState extends State<ClientAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [PlayerLoadPage(), PlayerLoadPage()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = ClientAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('PROMOTOR AMASZVENTAS'),
      drawer: DrawerMenu(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 21.0,
        backgroundColor: AppTheme.themeGrey,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.userTie,
                size: 25,
              ),
              title: Text('Promotor')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.moneyBill,
                size: 25,
              ),
              title: Text('Tus ventas')),
        ],
        currentIndex: page,
        unselectedItemColor: AppTheme.themeDefault,
        selectedItemColor: AppTheme.themeWhite,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
    );
  }
}

class ClientLoadPage extends StatefulWidget {
  static final String routeName = 'client';
  ClientLoadPage({Key key}) : super(key: key);

  @override
  _ClientLoadPageState createState() => _ClientLoadPageState();
}

class _ClientLoadPageState extends State<ClientLoadPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [PlayerLoadPage(), PlayerLoadPage()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = ClientAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('PROMOTOR AMASZVENTAS'),
      drawer: DrawerMenu(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 21.0,
        backgroundColor: AppTheme.themeGrey,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.userTie,
                size: 25,
              ),
              title: Text('Promotor')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.moneyBill,
                size: 25,
              ),
              title: Text('Tus ventas')),
        ],
        currentIndex: page,
        unselectedItemColor: AppTheme.themeDefault,
        selectedItemColor: AppTheme.themeWhite,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
    );
  }
}

class PlayerLoadPage extends StatefulWidget {
  static final String routeName = 'playerLoad';

  @override
  _PlayerLoadPageState createState() => _PlayerLoadPageState();
}

class _PlayerLoadPageState extends State<PlayerLoadPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final myController = TextEditingController();

  final prefs = new Preferense();

  NotificacionModel entity = new NotificacionModel();

  //
  bool _save = false;
  int valueImage = 0;
  File photo;
  String image = IMAGE_LOGO;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    entity.states = StateEntity.Insert;
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          background(context, ''),
          // crearFondo(context, imagen),
          _form(context),
        ],
      ),
      floatingActionButton: floatButton(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.plane), HomePage()),
    );
  }

  Widget _form(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            sizedBox(0.0, 15.0),
            Container(
              width: size.width * 0.94,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerImage(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  text('CARGA TU AVATAR EN LA APP.  ', AppTheme.themeGrey, 1,
                      15.0),
                  //       _crearIconAppImagenes(),
                  //      _crearIconAppCamara(),
                ],
              ),
            ),
            sizedBox(0.0, 10.0),
            Container(
              width: size.width * 0.94,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerFileds(),
              child: _fields(context),
            ),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  // _crearIconAppImagenes() {
  //   return IconButton(
  //     icon: Icon(
  //       Icons.photo_size_select_actual,
  //       color: AppTheme.themeGrey,
  //     ),
  //     onPressed: _seleccionarFoto,
  //   );
  // }

  // _crearIconAppCamara() {
  //   return IconButton(
  //     icon: Icon(
  //       Icons.camera_alt,
  //       color: AppTheme.themeGrey,
  //     ),
  //     onPressed: _tomarFoto,
  //   );
  // }

  Widget _fields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sizedBox(0.0, 7.0),
        showPictureOval(photo, image, 70.0),
        divider(),

        //     _tipo('Departamento : ', getTipo()),
        //  _comboBox('Departamento', _opcionDepartamento),

        _text(
            myController,
            'Marcelo Antonio',
            'Nombres',
            40,
            'Ingrese nombres del promotor',
            true,
            FaIcon(FontAwesomeIcons.userCircle, color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            myController,
            'Arce Valdivia',
            'Apellidos del promotor',
            40,
            'Ingrese apellidos del ptomotor',
            true,
            FaIcon(FontAwesomeIcons.userAlt, color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            myController,
            'AMSZ-4342092',
            'Codigo AMASZONAS',
            40,
            'Ingrese Codigo AMASZONAS',
            true,
            FaIcon(FontAwesomeIcons.solidAddressCard,
                color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            myController,
            '72038768',
            'Telefono WhatsApp',
            40,
            'Ingrese Telefono WhatsApp',
            true,
            FaIcon(FontAwesomeIcons.whatsapp, color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            myController,
            'Joven profesional con experiencia en la venta de productos.',
            'Acerca de ti..',
            140,
            'Ingrese sobre ti...',
            true,
            FaIcon(FontAwesomeIcons.mailBulk, color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            myController,
            'https://www.facebook.com/marcoantonio.lsxd',
            'Ingressa cuenta Facebook',
            120,
            'Ingrese su cuneta en facebook',
            true,
            FaIcon(FontAwesomeIcons.facebook, color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

//        _posibleVenta('Cliente para venta'),

        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),

        _button('Guardar', 18.0, 20.0),
        // gfCard(),
      ],
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

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      ClasificadorModel item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.idClasificador.toString(),
      ));
    }
    return lista;
  }

  // Widget _comboBox(String label, String values) {
  //   return Center(
  //       child: FutureBuilder(
  //           future: entityGet.get(new ClasificadorModel(), 3),
  //           builder: (context, AsyncSnapshot snapshot) {
  //             if (snapshot.hasData) {
  //               return Row(
  //                 children: <Widget>[
  //                   SizedBox(width: 35.0),
  //                   Text(label),
  //                   SizedBox(width: 15.0),
  //                   DropdownButton(
  //                     icon: FaIcon(FontAwesomeIcons.sort,
  //                         color: AppTheme.themeGrey),
  //                     value: _opcionDepartamento,
  //                     items: getDropDown(snapshot),
  //                     onChanged: (value) {
  //                       setState(() {
  //                         _opcionDepartamento = value;
  //                       });
  //                     },
  //                   ),
  //                 ],
  //               );
  //             } else {
  //               return GFLoader(type: GFLoaderType.circle, size: 35.0);
  //             }
  //           }));
  // }

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

    print('myControllerSOY EL VALOR DE ' + myController.text);

    setState(() => _save = true);
    loadingEntity();
    executeCUD(entity);
    setState(() => _save = false);
  }

  void loadingEntity() {
    print('EL RESULAAAAA');
    entity.idNotificacion =
        (entity.states == StateEntity.Insert) ? 0 : entity.idNotificacion;
    entity.idOrganizacion = 1;
    // entity.titulo = controllerTitulo.text;
    // entity.detalle = controllerDetalle.text;
    entity.usuarioAuditoria = 'prefs.email';
    entity.foto = IMAGE_LOGO;

    print('EL RESULAAAAA ${entity.titulo}');
    print('EL RESULAAAAA ${entity.detalle}');
  }

  void executeCUD(NotificacionModel entity) async {
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

  // _seleccionarFoto() async {
  //   _procesarImagen(ImageSource.gallery);
  // }

  // _tomarFoto() async {
  //   _procesarImagen(ImageSource.camera);
  // }

  // _procesarImagen(ImageSource origen) async {
  //   final photo = await ImagePicker().getImage(source: origen);
  //   if (photo != null) {
  //     image = await entityImage.uploadImage(photo.path);
  //     setState(() {
  //       entity.foto = image;

  //       //print('cargadod e iagen ${entity.foto}');
  //     });
  //   }
  // }
}
