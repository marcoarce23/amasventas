import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/personal/PersonalEditPage.dart';
import 'package:amasventas/src/page/ventas/VentasGastos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/crosscutting/Const.dart';
import 'src/page/home/HomePage.dart';
import 'src/page/login/LogOnPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Preferense();
  await prefs.initPrefs();
  runApp(MyApp());

  // DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(),
  // );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final prefs = new Preferense();
  String token;

  @override
  void initState() {
    super.initState();

    //final pushProvider = new PushNotificationProvider();
    // pushProvider.initNotifications();
    // pushProvider.mensajes.listen((data) {
    //   //print('Argumento del Push: $data');

    //   if (data == 'ayudaPersona')
    //     navigatorKey.currentState
    //         .pushNamed('CiudadanoEmergencia', arguments: data);
    //   else if (data == 'Voluntario')
    //     navigatorKey.currentState
    //         .pushNamed('EncuentraVoluntario', arguments: data);
    //   else if (data == 'organizacion')
    //     navigatorKey.currentState
    //         .pushNamed('ListaInstituciones', arguments: data);
    //   else if (data == 'emergencia')
    //     navigatorKey.currentState
    //         .pushNamed('CiudadanoEmergencia', arguments: data);
    //   else if (data == 'eventos')
    //     navigatorKey.currentState
    //         .pushNamed('CiudadanoEventos', arguments: data);
    //   else if (data == 'multimedia')
    //     navigatorKey.currentState
    //         .pushNamed('CiudadanoMultimedia', arguments: data);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: TITLE,
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        // localizationsDelegates: [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        // supportedLocales: [
        //   const Locale('en', 'US'), // English
        //   const Locale('es', 'ES'), // Hebrew
        // ],
        home: LogOnPage(),
        routes: <String, WidgetBuilder>{
          //        'splash': (BuildContext context) => new SplashPage(),
          'login': (BuildContext context) => new LogOnPage(),
          'home': (BuildContext context) => new HomePage(),
          'personal': (BuildContext context) => new PersonalAllPage(),
          'personalEdit': (BuildContext context) => new PersonalEditPage(),
          'AMP': (BuildContext context) => new VentaGastoPage(),
          'AMV': (BuildContext context) => new VentaGastoPage(),
        });
  }
}
