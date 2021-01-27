import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      right: true,
      top: true,
      bottom: true,
      child: null,
      
      // SplashScreen(
      //   backgroundColor: Colors.white, //AppTheme.themeDefault,
      //   seconds: 4,
      //   navigateAfterSeconds: new LogOnPage(),
      //   photoSize: 200,
      //   image: Image(
      //     image: AssetImage('assets/ico/ico.png'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
    );
  }
}
