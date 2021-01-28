import 'package:flutter/material.dart';
import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';

AppBar appBar(String title) {
  return AppBar(
    backgroundColor: AppTheme.themeGreen,
    //toolbarOpacity: 0.7,
    // iconTheme: IconThemeData(color: AppTheme.themeWhite, size: 16),
    elevation: 5.0,
    title: Text(title.toUpperCase(), style: kTitleAppBar),
    actions: <Widget>[
      //  DrawerMenu(),
      avatarCircle(IMAGE_LOGON, 35.0),

      //  FaIcon(
      //     FontAwesomeIcons.edit,
      //     color: AppTheme.themeRed,
      //     size: 23,
      //   ),
    ],
  );
}
