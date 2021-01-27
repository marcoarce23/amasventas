import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:amasventas/src/crosscutting/Preference.dart';

class LogOutPage extends StatefulWidget {
  @override
  _LogOutPageState createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {

  String _contactText;
  final prefs = new Preferense();

  @override
  void initState() {
    super.initState();

   
  }

   Widget _gmailButton() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: (){},//_handleSignOut, // _handleSignIn,
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
                'Cerrar sesión',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('CERAR SESIÓN ${prefs.nameUser.toString()}'),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: null,//_buildBody(),
        ));
  }
}
