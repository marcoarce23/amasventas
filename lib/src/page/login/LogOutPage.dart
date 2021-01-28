import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';

class LogOutPage extends StatefulWidget {
  @override
  _LogOutPageState createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  final prefs = new Preferense();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('CERAR SESIÓN ${prefs.nameUser.toString()}'),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: null, //_buildBody(),
        ));
  }
}
