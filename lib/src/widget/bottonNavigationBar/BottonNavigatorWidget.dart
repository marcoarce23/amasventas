import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/image/imageOvalWidget.dart';

class BottonNavigation extends StatefulWidget {
  BottonNavigation({Key key}) : super(key: key);

  @override
  _BottonNavigationState createState() => _BottonNavigationState();
}

class _BottonNavigationState extends State<BottonNavigation> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar.badge(
      {3: '200+', 1: '10+', 2: '3+'},

      backgroundColor: AppTheme.themeDefault,
      badgeColor: AppTheme.themePurple,
      style: TabStyle.reactCircle,
      elevation: 3.0,
      items: [
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: 'Noticias'),
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: 'Ganadores'),
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: 'Torneos',
            isIconBlend: false),
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: 'Jugador'),
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: '1 Vs.1'),
      ],
      initialActiveIndex: 2, //optional, default as 0
      onTap: (value) {
        setState(() {
          // if (value == 0) navegation(context, NewListPage());
          // if (value == 1) navegation(context, PlayerWinnerPage());
          // if (value == 2) navegation(context, ListTournamentPage());
          // if (value == 3) navegation(context, PlayerLoadPage());
          // if (value == 4) navegation(context, PlayerLoadPage());
        });
      },
    );
  }
}
