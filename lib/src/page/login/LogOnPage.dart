import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/crosscutting/StatusCode.dart';
import 'package:amasventas/src/data/entity/EntityMap/LogOnModel.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';
import 'package:amasventas/src/page/amasventas/SimuladorVentasPage.dart';
import 'package:amasventas/src/page/intro/IntroPage.dart';
import 'package:amasventas/src/page/login/ChangePasswordPage.dart';
import 'package:amasventas/src/page/login/RegisterUserPage.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:amasventas/src/repository/route/LogOnApi.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:amasventas/src/page/general/ViewPage.dart';
import 'package:amasventas/src/page/login/LoginClipperPage.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/crosscutting/Validator.dart' as validator;
import 'package:local_auth/local_auth.dart';
import 'package:shimmer/shimmer.dart';

class LogOnPage extends StatefulWidget {
  @override
  _LogOnPageState createState() => _LogOnPageState();
}

class _LogOnPageState extends State<LogOnPage> {
  final controllerLogin = TextEditingController();
  final controllerPass = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _save = false;

  LogOnModel entity = new LogOnModel();
  LogOnADModel entityAD = new LogOnADModel();
  final prefs = new Preferense();

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'No Autorizado';
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Autenticando';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scannea tu huella dactilar para autentificar',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Autorizado';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Autorizado' : 'No Autorizado';
    setState(() {
      _authorized = message;
      if (_authorized == 'Autorizado')
        navegation(context, IntroPage());
      else
        return;
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    entityAD.apiUrl = LogOnApi().apiAD();

    entityAD.states = StateEntity.Insert;

    entity.apiUrl = LogOnApi().api();
    entity.states = StateEntity.Insert;

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(),
            // Image(image: AssetImage("assets/image/babycare1.jpg")),

            //     Image.asset(
            ////        "assets/image/babycare1.jpg",
            // fit: BoxFit.cover,
            // height: size.height * 0.70,
            // width: size.width,
            //    ),
            Center(
              child: Image(
                image: NetworkImage(IMAGE_LOGON),
                fit: BoxFit.cover,
                height: size.height,
                width: size.width,
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: LoginCustomClipper(),
                child: _buttonsSignUp(size, context),
              ),
            )
          ],
        ),
      ),
    );
  }

  _crearUsuario(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: AppTheme.themeBlackBlack,
            highlightColor: AppTheme.themeGreen,
            child: FlatButton(
              child: Text(
                'Registrate aquí.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () => navegation(
                context,
                RegisterUserPage(),
              ),
            ),
          ),
          FaIcon(
            FontAwesomeIcons.edit,
            color: AppTheme.themeBlackBlack,
            size: 18,
          ),
        ],
      ),
    );
  }

  Container _buttonsSignUp(Size size, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 55),
      height: size.height * 0.52,
      width: size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /* 
          Shimmer.fromColors(
            baseColor: AppTheme.themeDefault,
            highlightColor: AppTheme.themeRed,
            child: AutoSizeText(
              'Somos Amasventas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _button('Iniciar con tu cuenta', 18.0, 20.0),
          */
          _text(
              controllerLogin,
              '',
              '(*) Ingrese su usuario',
              25,
              1,
              'Ingrese su usuario',
              true,
              FaIcon(FontAwesomeIcons.user, color: AppTheme.themeBlackBlack),
              AppTheme.themeBlackBlack,
              AppTheme.themeBlackBlack,
              Colors.red),
          _text(
              controllerPass,
              '',
              '(*) Ingese la contraseña',
              10,
              1,
              'Ingrese la contraseña',
              true,
              FaIcon(FontAwesomeIcons.key, color: AppTheme.themeBlackBlack),
              AppTheme.themeDefault,
              AppTheme.themeDefault,
              AppTheme.themeGreen),
          _button('Iniciar Sesión', 18.0, 60.0),
          //    _crearUsuario(context),
          _crearAcciones(context),
          copyRigthBlack(),
/*
          Text('El dispositivo tiene para huella?: $_canCheckBiometrics\n'),
          RaisedButton(
            child: const Text('Verificar si tiene para huella'),
            onPressed: _checkBiometrics,
          ),
          Text('Biometrico disponible: $_availableBiometrics\n'),
          RaisedButton(
            child: const Text('Obtener tipo de verificacion'),
            onPressed: _getAvailableBiometrics,
          ),
          Text('Estado de la verificación: $_authorized\n'),
          RaisedButton(
            child: Text(_isAuthenticating ? 'Cancelar' : 'Autentificar'),
            onPressed:
                _isAuthenticating ? _cancelAuthentication : _authenticate,
          )*/
        ],
      ),
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
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 35.0),
      child: TextFormField(
        initialValue: initialValue,
        textCapitalization: TextCapitalization.sentences,
        enableSuggestions: false,
        autocorrect: true,
        autovalidate: false,
        maxLines: maxLines,
        cursorColor: AppTheme.themeGreen,
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
      padding: const EdgeInsets.only(left: 5),
      elevation: 15.0,
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeGreen,
      icon: FaIcon(FontAwesomeIcons.checkCircle, color: AppTheme.themeWhite),
      shape: GFButtonShape.pills,
      onPressed: (_save) ? null : _submit,
    );
  }
/*
  _submitAD() {
    entityAD.apiUrl = LogOnApi().apiAD();
    entityAD.usuario = controllerLogin.text;
    entityAD.contrasenia = controllerPass.text;
    return _executeCUDAD(entityAD);
  }
  */

  _submit() async {
    // if (controllerPass.text == '1234') {
    //   navegation(context, ChangePasswordPage());
    // }
    // if (!formKey.currentState.validate()) return;
    //  formKey.currentState.save();
    //else {
    entityAD.apiUrl = LogOnApi().apiAD();
    entityAD.usuario = controllerLogin.text.toLowerCase();
    entityAD.contrasenia = controllerPass.text;

    executeCUD(entityAD);
    // }
/*
    if (_submitAD() == '0') {
      setState(() => _save = true);
      setState(() => _save = false);
    } else {
      setState(() => _save = true);
      executeCUD(entity);
      loadingEntity();
      setState(() => _save = false);
    }
    */
  }

  void loadingEntity() {
    entityAD.apiUrl = LogOnApi().apiAD();
    entityAD.usuario = controllerLogin.text.toLowerCase();
    entityAD.contrasenia = controllerPass.text;

    print('EL RESULAAAAA ${entity.apiUrl}');
  }
/*
  _executeCUDAD(LogOnADModel entity) async {
    print('EL RESULAAccccA');
    String _valor = '3';

    Repository().add(entity).then((result) {
      if (result["tipo_mensaje"] == "0") {
        print('WWWWWW ${result["tipo_mensaje"].toString()}');
        _valor = result["tipo_mensaje"].toString();
      } else
        showSnackbar(STATUS_ERROR, scaffoldKey);
    });
    print('WWWWWW $_valor');
    return _valor;
    //  await responseMessageService(response, scaffoldKey);
  }
  */

  void executeCUD(LogOnADModel entity) async {
    print('EL RESULZZZZZZ');

    try {
      await Repository().add(entity).then((result) {
        if (result["tipo_mensaje"] == "0") {
          prefs.nameUser = entity.usuario;
          // navegation(context, SimuladorVentasPage()); //IntroPage());
          navegation(context, IntroPage());
        } else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (exception) {
      showSnackbar('No tiene acceso al sistema', scaffoldKey);
    }

    //  await responseMessageService(response, scaffoldKey);
  }

  Row _crearAcciones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: RaisedButton(
            color: Colors.blueAccent,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () => navegation(
                context,
                ViewPage(
                    title: 'FACEBOOK AMASZONAS'.toString(), url: facebook)),
            child: Icon(
              FontAwesomeIcons.facebookF,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        sizedBox(10, 0),
        SizedBox(
          width: 30,
          height: 30,
          child: RaisedButton(
            color: Colors.red,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () => navegation(
                context,
                ViewPage(
                    title: 'INSTAGRAM AMASZONAS'.toString(), url: instagram)),
            child: Icon(
              FontAwesomeIcons.instagram,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        sizedBox(10, 0),
        SizedBox(
          width: 30,
          height: 30,
          child: RaisedButton(
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () => navegation(
                context,
                ViewPage(
                    title: 'TWITTER AMASZONAS'.toString(), url: instagram)),
            child: Icon(
              FontAwesomeIcons.twitter,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        sizedBox(10, 0),
        SizedBox(
          width: 30,
          height: 30,
          child: RaisedButton(
            color: Colors.blue,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () => navegation(context,
                ViewPage(title: 'LINKDIN AMASZONAS'.toString(), url: linkDin)),
            child: Icon(
              FontAwesomeIcons.linkedinIn,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
