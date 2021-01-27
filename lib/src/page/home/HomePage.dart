import 'dart:io';
import 'package:flutter/material.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/faq/FaqPage.dart';
import 'package:amasventas/src/page/home/CircularMenuPage.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = new Preferense();
  File photo;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  void initState() {
    // generic.add(
    //     new TokenImei(
    //         correo1: prefs.correoElectronico,
    //         imei: prefs.imei,
    //         token: prefs.token),
    //     urlAddTokenImei);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    prefs.lastPage = HomePage.routeName;
    return SafeArea(
      left: true,
      right: true,
      bottom: true,
      top: true,
      child: Scaffold(
        appBar: appBar('Virtual Match'),
        body: FaqPage(),
        drawer: DrawerMenu(),
        bottomNavigationBar: new BottonNavigation(),
      ),
    );
  }
}
