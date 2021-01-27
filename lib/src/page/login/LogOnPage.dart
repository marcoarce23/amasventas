import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:shimmer/shimmer.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/LogOnModel.dart';
import 'package:amasventas/src/data/entity/EntityMap/LogOnModel.dart' as model;
import 'package:amasventas/src/page/general/ViewPage.dart';
import 'package:amasventas/src/page/intro/IntroPage.dart';
import 'package:amasventas/src/page/login/LoginClipperPage.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/CallWidget.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/general/SenWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';
import 'package:amasventas/src/crosscutting/Validator.dart' as validator;

class LogOnPage extends StatefulWidget {
  @override
  _LogOnPageState createState() => _LogOnPageState();
}

class _LogOnPageState extends State<LogOnPage> {
  // LoginService loginService1;

  // LoginService loginService = new LoginService();
  LoginModel loginModel = new LoginModel();
  model.LoginModel entity = new model.LoginModel();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = new Preferense();
  final controllerUsuario = TextEditingController();
  final controllerPassword = TextEditingController();

  //LoginSigIn entity = new LoginSigIn();
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  String result2;
  var result;
  var result1;

  @override
  void initState() {
    super.initState();
    // prefs.lastPage = LoginPage.routeName;
    initPlatformState();
  
  }

  Future<void> initPlatformState() async {
    String platformImei = 'Failed to get platform version.';
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      idunique = await ImeiPlugin.getId();
    } catch (exception) {
      showSnackbar('Se produjo un error. $exception', scaffoldKey);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;
      uniqueId = idunique;
    });
  }

  @override
  Widget build(BuildContext context) {
    // loginService1 = Provider.of<LoginService>(context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(),
              Image.asset(
                "assets/image/babycare1.jpg",
                fit: BoxFit.cover,
                height: size.height * 0.99,
                width: size.width,
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
      ),
    );
  }

  Container _buttonsSignUp(Size size, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      //  height: size.height * 0.5,
      width: size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: AppTheme.themeDefault,
            highlightColor: AppTheme.themePurple,
            child: AutoSizeText(
              'Bienvenido al amasventas',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          sizedBox(0, 60),
          _text(
              controllerUsuario,
              '',
              '(*) Registre la noticia/evento',
              100,
              2,
              'Ingrese la noticia',
              true,
              FaIcon(FontAwesomeIcons.newspaper, color: AppTheme.themeDefault),
              AppTheme.themeDefault,
              AppTheme.themeDefault,
              Colors.red),
          _text(
              controllerPassword,
              '',
              '(*) Registre la noticia/evento',
              100,
              2,
              'Ingrese la noticia',
              true,
              FaIcon(FontAwesomeIcons.newspaper, color: AppTheme.themeDefault),
              AppTheme.themeDefault,
              AppTheme.themeDefault,
              Colors.red),

          _gmailButton(),
          //  _button(context, 'amasventas', 18.0, 20.0),
          _crearAcciones(context),
          sizedBox(0.0, 8.0),
          _egree(context),
          copyRigthBlack(),
        ],
      ),
    );
  }

  Future<void> handleSignIn() async {
    try {
    
        _crearInformacion();
      
    } catch (error) {
      // scaffoldKey.currentState
      //     .showSnackBar('Se produjo un error: ${error.toString()}');
    }
  }

  _crearInformacion() {
    // _googleSignIn.signIn().then((value) {
    //   prefs.nameUser = currentUser.displayName;
    //   prefs.email = currentUser.email;
    //   prefs.avatarImage = currentUser.photoUrl;
    //   prefs.userId = currentUser.displayName;

    //   print('DDDD. ${prefs.email}');

    //   _submit();
    // });
    _submit();
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

  Widget _gmailButton() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: handleSignIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/general/google_logo.png"),
                height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _crearAcciones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: RaisedButton(
            color: Colors.blueAccent,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () => navegation(
                context,
                ViewPage(
                    title: 'FACEBOOK amasventas'.toString(), url: facebook)),
            child: Icon(
              FontAwesomeIcons.facebookF,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        sizedBox(10, 0),
        SizedBox(
          width: 40,
          height: 40,
          child: RaisedButton(
            color: Colors.red,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () => navegation(
                context,
                ViewPage(
                    title: 'FACEBOOK amasventas'.toString(), url: instagram)),
            child: Icon(
              FontAwesomeIcons.instagram,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        sizedBox(10, 0),
        SizedBox(
          width: 40,
          height: 40,
          child: RaisedButton(
            color: Colors.green,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () {
              callWhatsAppText(whatsApp,
                  '* amasventas:* \n Mensaje. Me gustaría ponerme en contacto. Gracias. \nEnviado desde la aplicación \n*amasventas Digital*.');
            },
            child: Icon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        sizedBox(10, 0),
        SizedBox(
          width: 40,
          height: 40,
          child: RaisedButton(
            color: Colors.grey,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () {
              sendEmailAdvanced(
                  email,
                  "Comunidad amasventas. Deseo comunicarme con usted.",
                  "A la Comunidad amasventas:\n Deseo más información sobre la Comunidad y de como formar parte de FIFA BOLIVIA.\n Saludos cordiales. Gracias");
            },
            child: Icon(
              FontAwesomeIcons.solidEnvelope,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  _egree(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text('Política de Privacidad'),
            onPressed: () => Navigator.push(
              context,
              PageTransition(
                curve: Curves.bounceOut,
                type: PageTransitionType.rotate,
                alignment: Alignment.topCenter,
                child: ViewPage(
                    title: 'Políticas de Privacidad',
                    url: 'https://www.amasventas.bo/politicas-de-privacidad'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(
      BuildContext context, String text, double fontSize, double edgeInsets) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: edgeInsets),
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeBlackBlack,
      icon: avatarCircle(IMAGE_DEFAULT, 20),
      // Shimmer.fromColors(
      //   baseColor: AppTheme.themePurple,
      //   highlightColor: AppTheme.themeWhite,
      //   child: avatarCircle(IMAGE_LOGOB, 35),
      // ),
      shape: GFButtonShape.pills,
      onPressed: () => navegation(context, IntroPage()),
    );
  }

  // Widget _botonInvitado(String text) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 70.0),
  //     width: MediaQuery.of(context).size.width,
  //     child: RaisedButton.icon(
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  //       color: AppTheme.themeDefault,
  //       textColor: Colors.white,
  //       label: Text(
  //         text,
  //         style: kSubtitleStyle,
  //       ),
  //       icon: FaIcon(FontAwesomeIcons.earlybirds, color: Colors.white),
  //       onPressed: () {
  //         // prefs.imei = entity.imei;
  //         // prefs.nombreUsuario = 'Invitado';
  //         // prefs.correoElectronico = 'Invitado';
  //         // prefs.nombreInstitucion = 'Invitado';
  //         // prefs.idInsitucion = '0';
  //         // prefs.idPersonal = '-2';
  //         // prefs.userId = '0';

  //         // Navigator.push(
  //         //     context,
  //         //     PageTransition(
  //         //       curve: Curves.bounceOut,
  //         //       type: PageTransitionType.rotate,
  //         //       alignment: Alignment.topCenter,
  //         //       child: LoginPage(),
  //         //     ));
  //       },
  //     ),
  //   );
  // }

  _submit() async {
    navegation(context, IntroPage());
    loadingEntity();
    //  executeCUD(loginService, entity);
  }

  void loadingEntity() {
    // entity.states = StateEntity.Insert;
    // entity.foto = prefs.avatarImage;
    // entity.nombre = prefs.nameUser;
    // entity.correo = prefs.email;
    // entity.imei = _platformImei;
    // entity.token = prefs.token;
  }

  // void executeCUD(LoginService entityService, model.LoginModel entity) async {
  //   try {
  //     await entityService.repository(entity).then((result) {
  //       print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
  //       if (result["tipo_mensaje"] == '0') {
  //         //  showSnackbar(STATUS_OK, scaffoldKey);
  //         prefs.idLogin = result["data"]["idLogin"].toString();
  //         navegation(context, HomePage());
  //       } else
  //         showSnackbar(STATUS_ERROR, scaffoldKey);
  //     });
  //   } catch (error) {
  //     showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
  //   }
  // }
}
