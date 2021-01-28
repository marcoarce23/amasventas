import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/page/faq/FaqPage.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/image/imageOvalWidget.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottonNavigation extends StatefulWidget {
  BottonNavigation({Key key}) : super(key: key);

  @override
  _BottonNavigationState createState() => _BottonNavigationState();
}

class _BottonNavigationState extends State<BottonNavigation> {
  @override
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar.badge(
      {3: '', 1: '', 2: ''},

      backgroundColor: AppTheme.themeWhite,
      badgeColor: AppTheme.themeRed,
      style: TabStyle.reactCircle,
      color: AppTheme.themeGreen,
      elevation: 3.0,
      items: [
        TabItem(
            icon: FaIcon(FontAwesomeIcons.shareAlt,
                size: 20, color: AppTheme.themeBlackGrey),
            title: 'Notificacón'),
        TabItem(
            icon: FaIcon(FontAwesomeIcons.shareAlt,
                size: 20, color: AppTheme.themeBlackGrey),
            title: 'Faq'),
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGON, sizeImage: Size.fromWidth(50)),
            title: 'Compartir',
            isIconBlend: false),
        TabItem(
            icon: FaIcon(FontAwesomeIcons.shareAlt,
                size: 20, color: AppTheme.themeBlackGrey),
            title: 'Compartir'),
        TabItem(
            icon: FaIcon(FontAwesomeIcons.shareAlt,
                size: 20, color: AppTheme.themeBlackGrey),
            title: 'Contactos'),
      ],
      initialActiveIndex: 2, //optional, default as 0
      onTap: (value) {
        setState(() {
          if (value == 0) navegation(context, FaqPage());
          if (value == 1) navegation(context, FaqPage());
          if (value == 2) navegation(context, FaqPage());
          if (value == 3) navegation(context, FaqPage());
          if (value == 4) navegation(context, FaqPage());
        });
      },
    );
  }
}
