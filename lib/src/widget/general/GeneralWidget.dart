import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/page/general/ViewPage.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/OpenWebWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';

// Widget showInformationBasicIcon(
//     BuildContext context, String title, String subTitle, FaIcon icon,) {
//   final size = MediaQuery.of(context).size;
//   return Container(
//     width: size.width * 0.95,
//     margin: EdgeInsets.symmetric(vertical: 0.0),
//     decoration: boxDecoration(),
//     child: Column(
//       children: <Widget>[
//         gfListTile(
//             Text(title, style: kTitleStyleBlack),
//          null,
//             null,
//             null,
//             avatarCircle(icon, 35),
//             EdgeInsets.all(5.0),
//             EdgeInsets.all(3.0)),
//       ],
//     ),
//   );

Widget showInformationBasic(
    BuildContext context, String title, String subTitle) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.95,
    margin: EdgeInsets.symmetric(vertical: 0.0),
    decoration: boxDecoration(),
    child: Column(
      children: <Widget>[
        gfListTile(
            Text(title, style: kTitleStyleBlack),
            Text(subTitle, style: kSubtitleStyleBlack),
            null,
            null,
            avatarCircle(IMAGE_LOGON, 35),
            EdgeInsets.all(5.0),
            EdgeInsets.all(3.0)),
      ],
    ),
  );
  //Text(entity.nombreEquipo);
}

Widget showInformationMenu(
    BuildContext context, String title, String subTitle, String logo) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.95,
    margin: EdgeInsets.symmetric(vertical: 0.0),
    decoration: boxDecorationMenus(),
    child: Column(
      children: <Widget>[
        gfListTile(
            Text(title, style: kTitleStyleBlack),
            Text(subTitle, style: kSubtitleStyleBlack),
            null,
            null,
            avatarCircle(logo, 35),
            EdgeInsets.all(5.0),
            EdgeInsets.all(3.0)),
      ],
    ),
  );
  //Text(entity.nombreEquipo);
}

Widget showInformation(BuildContext context, String title, String subTitle,
    String subSubTitle, String titlePage, String url) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.95,
    margin: EdgeInsets.symmetric(vertical: 0.0),
    decoration: boxDecoration(),
    child: Column(
      children: <Widget>[
        gfListTile(
            Text(title),
            Text(subTitle),
            Row(
              children: <Widget>[
                Text(
                  subSubTitle,
                  style: TextStyle(
                      color: AppTheme.themeRed,
                      textBaseline: TextBaseline.ideographic,
                      //   decoration: TextDecoration.underline,
                      fontSize: 15.0),
                ),
                InkWell(
                  child: avatarCircle(IMAGE_SCREEN1, 20),
                  onTap: () =>
                      navegation(context, ViewPage(title: titlePage, url: url)),
                ),
              ],
            ),
            null,
            avatarCircle(IMAGE_LOGO, 35),
            EdgeInsets.all(5.0),
            EdgeInsets.all(3.0)),
      ],
    ),
  );
  //Text(entity.nombreEquipo);
}

Widget copyRigth() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      sizedBox(0, 5.0),
      divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(amasventas,
              style: TextStyle(
                  color: AppTheme.themeWhite)), //style: kCopyRigthStyle),
          avatarCircle(IMAGE_LOGON, 10),
        ],
      ),
    ],
  );
}

Widget copyRigthBlack() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      sizedBox(0, 5.0),
      dividerGreen(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(amasventas, style: TextStyle(color: AppTheme.themeBlackBlack)),
          FaIcon(FontAwesomeIcons.plane, color: AppTheme.themeGreen),
        ],
      ),
    ],
  );
}

Divider divider() {
  return Divider(
    thickness: 2.0,
    color: AppTheme.themeWhite,
    endIndent: 20.0,
    indent: 20.0,
  );
}

Divider dividerGreen() {
  return Divider(
    thickness: 2.0,
    color: AppTheme.themeDefault,
    endIndent: 20.0,
    indent: 20.0,
  );
}

Divider dividerBlue() {
  return Divider(
    thickness: 2.0,
    color: Colors.blue,
    endIndent: 20.0,
    indent: 20.0,
  );
}

Divider dividerWidth(double thickness, Color color) {
  return Divider(
    thickness: thickness,
    color: color,
    endIndent: 20.0,
    indent: 20.0,
  );
}

SizedBox sizedBox(double ancho, double alto) {
  return SizedBox(
    width: ancho,
    height: alto,
  );
}

Widget text(String text, Color color, int maxLines, double size) {
  return Text(text,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
      )
      //  strutStyle: StrutStyle.fromTextStyle(textStyle),
      );
}

navegation(BuildContext context, Widget page) {
  Navigator.push(
      context,
      PageTransition(
        curve: Curves.bounceOut,
        type: PageTransitionType.rotate,
        alignment: Alignment.topCenter,
        child: page,
      ));
}

inputDecoration(String hintText, String labelText, FaIcon icon,
    Color hoverColor, Color fillColor, Color focusColor) {
  return InputDecoration(
    focusColor: focusColor,
    hintText: hintText,
    labelText: labelText,
    icon: icon,
    hoverColor: hoverColor,
    fillColor: fillColor,
  );
}

Widget backgroundBasic(BuildContext context) {
//  final size = MediaQuery.of(context).size;

  return Container(
    // height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      stops: [0.1, 0.4, 0.7, 0.9],
      colors: [
        Color.fromRGBO(113, 113, 113, 1.0),
        Color.fromRGBO(93, 93, 93, 3.0),
        Color.fromRGBO(48, 50, 48, 1.0),
        Color.fromRGBO(22, 23, 22, 1.0),
      ],
    )),
  );
}

Widget backgroundImage(BuildContext context, String imagen) {
  final size = MediaQuery.of(context).size;

  return Container(
    height: size.height * 0.30,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      stops: [0.1, 0.4, 0.7, 0.9],
      colors: [
        Color.fromRGBO(113, 113, 113, 1.0),
        Color.fromRGBO(93, 93, 93, 3.0),
        Color.fromRGBO(48, 50, 48, 1.0),
        Color.fromRGBO(22, 23, 22, 1.0),
      ],
    )),
  );
}

Widget background(BuildContext context, String imagen) {
  final size = MediaQuery.of(context).size;

  return Container(
    height: size.height * 0.30,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      stops: [0.1, 0.4, 0.7, 0.9],
      colors: [
        // Color.fromRGBO(113, 113, 113, 1.0),
        // Color.fromRGBO(93, 93, 93, 3.0),
        // Color.fromRGBO(48, 50, 48, 1.0),
        // Color.fromRGBO(22, 23, 22, 1.0),
        Colors.white60, Colors.white60, Colors.white60, Colors.white60,
        // AppTheme.themeWhite, AppTheme.themeWhite, AppTheme.themeWhite,
        // AppTheme.themeWhite,
      ],
    )),
  );
}

BoxDecoration containerFileds1(Color color) {
  // return boxDecorationList();
  return BoxDecoration(
      color: color,
      // gradient: boxDecorationList(),
      borderRadius: BorderRadius.circular(4.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.themeBlackGrey,
            blurRadius: 5.0,
            offset: Offset(1.0, 1.0),
            spreadRadius: 1.0)
      ]);
}

BoxDecoration containerFileds() {
  // return boxDecorationList();
  return BoxDecoration(
      color: AppTheme.themeWhite,
      // gradient: boxDecorationList(),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.themeBlackGrey,
            blurRadius: 5.0,
            offset: Offset(1.0, 1.0),
            spreadRadius: 1.0)
      ]);
}

BoxDecoration containerImage() {
  return BoxDecoration(
      color: AppTheme.themeWhite,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.themeRed,
            blurRadius: 15.0,
            offset: Offset(2.0, 1.0),
            spreadRadius: 2.0)
      ]);
}

boxDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(3.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.themeGrey,
            blurRadius: 2.0,
            offset: Offset(1.0, 2.0),
            spreadRadius: 2.5)
      ],
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        stops: [0.1, 0.4, 0.7, 0.9],
        colors: [
          // Color.fromRGBO(113, 113, 113, 1.0),
          // Color.fromRGBO(93, 93, 93, 3.0),
          // Color.fromRGBO(48, 50, 48, 1.0),
          // Color.fromRGBO(22, 23, 22, 1.0),

          AppTheme.themeWhite, AppTheme.themeWhite, AppTheme.themeWhite,
          AppTheme.themeWhite,
        ],
      ));
}

boxDecorationColor(Color color) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(3.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.themeGrey,
            blurRadius: 2.0,
            offset: Offset(1.0, 2.0),
            spreadRadius: 2.5)
      ],
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        stops: [0.1, 0.4, 0.7, 0.9],
        colors: [
          // Color.fromRGBO(113, 113, 113, 1.0),
          // Color.fromRGBO(93, 93, 93, 3.0),
          // Color.fromRGBO(48, 50, 48, 1.0),
          // Color.fromRGBO(22, 23, 22, 1.0),

          color, color, color, color
        ],
      ));
}

boxDecorationMenus() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.themeGrey,
            blurRadius: 2.0,
            offset: Offset(1.0, 2.0),
            spreadRadius: 2.5)
      ],
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        stops: [0.1, 0.4, 0.7, 0.9],
        colors: [
          // Color.fromRGBO(113, 113, 113, 1.0),
          // Color.fromRGBO(93, 93, 93, 3.0),
          // Color.fromRGBO(48, 50, 48, 1.0),
          // Color.fromRGBO(22, 23, 22, 1.0),

          AppTheme.themeWhite, AppTheme.themeWhite, AppTheme.themeWhite,
          AppTheme.themeWhite,
        ],
      ));
}

boxDecorationMenu(BuildContext context, String imagen) {
  return BoxDecoration(
    image: new DecorationImage(
      image: new NetworkImage(IMAGE_LOGON),
      fit: BoxFit.cover,
    ),
    color: AppTheme.themeDefault,
  );
  //     gradient: LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomRight,
  //   stops: [0.1, 0.4, 0.7, 0.9],
  //   colors: [
  //     Color.fromRGBO(113, 113, 113, 1.0),
  //     Color.fromRGBO(93, 93, 93, 3.0),
  //     Color.fromRGBO(48, 50, 48, 1.0),
  //     Color.fromRGBO(22, 23, 22, 1.0),
  //   ],
  // ));
}

Widget generaHttpText(String cadena, String text) {
  if (cadena.contains("http") ||
      cadena.contains("https") ||
      cadena.contains("www")) {
    return InkWell(
      child: Text(text),
      onTap: () {
        openWeb(cadena);
      },
    );
  } else {
    return Text(cadena,
        style: kSubTitleCardStyle, overflow: TextOverflow.clip, softWrap: true);
  }
}

Widget generaHttpIcon(
    String cadena, FaIcon icon, int maxLines, double minFontSize) {
  if (cadena.contains("http") ||
      cadena.contains("https") ||
      cadena.contains("www")) {
    return InkWell(
      child: icon,
      onTap: () {
        openWeb(cadena);
      },
    );
  } else {
    return AutoSizeText(cadena,
        style: kSubTitleCardStyle,
        overflow: TextOverflow.clip,
        softWrap: true,
        maxLines: maxLines,
        minFontSize: minFontSize);
  }
}

Widget floatButton(
    Color color, BuildContext context, FaIcon icon, Widget page) {
  return FloatingActionButton(
    onPressed: () {
      navegation(context, page);
    },
    elevation: 2.0,
    child: icon,
    backgroundColor: color,
  );
}

Widget floatButtonImage(
    Color color, BuildContext context, FaIcon icon, Widget page) {
  return FloatingActionButton(
    onPressed: () {
      navegation(context, page);
    },
    elevation: 2.0,
    child: avatarCircle(IMAGE_LOGO, 34.0),
    backgroundColor: color,
  );
}

showSnackbar(String message, GlobalKey<ScaffoldState> scaffoldKey) {
  final snackbar = SnackBar(
    backgroundColor: AppTheme.themeRed,
    content: Text(message),
    duration: Duration(milliseconds: 2500),
  );

  scaffoldKey.currentState.showSnackBar(snackbar);
}

showSnackbarWithOutKey(String message, BuildContext context) {
  return Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: AppTheme.themeGreen,
    content: Text(message),
    duration: Duration(milliseconds: 2500),
  ));
}
