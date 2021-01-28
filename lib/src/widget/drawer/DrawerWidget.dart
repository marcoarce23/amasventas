import 'package:amasventas/src/page/general/ViewPage.dart';
import 'package:amasventas/src/page/login/ChangePasswordPage.dart';
import 'package:amasventas/src/page/login/LogOnPage.dart';
import 'package:amasventas/src/page/new/NewLoadPage.dart';
import 'package:amasventas/src/page/new/NewPage.dart';
import 'package:amasventas/src/page/notification/NotificationLoadPage.dart';
import 'package:amasventas/src/page/notification/NotificationPage.dart';
import 'package:amasventas/src/page/personal/PersonalListPage.dart';
import 'package:amasventas/src/widget/general/CallWidget.dart';
import 'package:amasventas/src/widget/general/SenWidget.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/page/faq/FaqPage.dart';
import 'package:amasventas/src/page/intro/IntroPage.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/general/SharedWidget.dart';

class CustomListTile extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: InkWell(
          splashColor: AppTheme.themeWhite,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  icon,
                  Text(
                    text,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ]),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final prefs = new Preferense();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: boxDecorationMenu(context, IMAGE_SCREEN1),
          child: Container(
              child: Column(
            children: <Widget>[
              Material(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: avatarCircle(IMAGE_LOGON, 58),
                    // child: ImageOvalNetwork(
                    //     imageNetworkUrl: prefs.avatarImage, //IMAGE_LOGO,
                    //     sizeImage: Size.fromWidth(70)),

                    //  child: showPictureOval(null, IMAGE_SOROJCHI, 70.0),
                  )),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Bienvenido !!!',
                        style: TextStyle(
                            color: AppTheme.themeWhite, fontSize: 18.0),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    AutoSizeText(
                      'Usuario: ${prefs.nameUser}',
                      style:
                          TextStyle(color: AppTheme.themeWhite, fontSize: 16.0),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
        CustomListTile(
            FaIcon(FontAwesomeIcons.user, size: 25, color: Colors.blueGrey),
            '   Perfil de Usuario',
            () => navegation(context, PersonalListPage())),
        CustomListTile(
            FaIcon(FontAwesomeIcons.bell, size: 25, color: Colors.purple),
            '   Notificaciones',
            () => navegation(context, NotificationPage())),
        CustomListTile(
            FaIcon(FontAwesomeIcons.images, size: 25, color: Colors.brown),
            '   Imágenes multimedia',
            () => navegation(context, MultimediaPage())),
        CustomListTile(
            FaIcon(FontAwesomeIcons.facebook, size: 25, color: Colors.blue),
            '   Estamos en Facebook',
            () => navegation(
                context,
                ViewPage(
                    title: 'PAGINA OFICIAL DE AMASZONAS'.toString(),
                    url: facebook))),
        CustomListTile(
            FaIcon(FontAwesomeIcons.twitter, size: 25, color: Colors.lightBlue),
            '   Estamos en Twitter',
            () => navegation(
                context,
                ViewPage(
                    title: 'PAGINA OFICIAL DE AMASZONAS'.toString(),
                    url: twitter))),
        CustomListTile(
            FaIcon(FontAwesomeIcons.instagram, size: 25, color: Colors.red),
            '   Estamos en Instagram',
            () => navegation(
                context,
                ViewPage(
                    title: 'PAGINA OFICIAL DE AMASZONAS'.toString(),
                    url: instagram))),
        CustomListTile(
          FaIcon(FontAwesomeIcons.mailBulk, size: 25, color: Colors.red),
          '   Contactanos',
          () => sendEmailAdvanced(
              'amaszonas@amaszonas.com',
              'SRES. AMASZONAS DESEO COMUNICARME CON UDS.',
              'De mi consideración: \n\n Tengan un buen día. Deseo comunciarme con ustedes para poder conocer sobre información sobre Amasventas. \n\n Saludos cordiales.'),
        ),
        CustomListTile(
          FaIcon(FontAwesomeIcons.whatsapp, size: 25, color: Colors.green),
          '   Comunicate con nosotros',
          () => callWhatsAppText(69091983,
              '*Comunicate Amaszonas* \n Mensaje. Me gustaría ponerme en contacto con ud. Gracias. \nEnviado desde la aplicación \n*Amaszonas Digital*.'),
        ),
        CustomListTile(
            FaIcon(FontAwesomeIcons.newspaper, size: 25, color: Colors.orange),
            '   Crear Notificaciones',
            () => navegation(context, NotificationAllPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.edit,
              size: 25,
            ),
            '   Crear Imágenes multimedia',
            () => navegation(context, MultimediaAllPage())),
        CustomListTile(
            FaIcon(FontAwesomeIcons.shareAlt,
                size: 25, color: AppTheme.themeBlackGrey),
            '    Comparte la aplicación',
            () => sharedText(
                'BIENVENIDO A AMASZVENTAS',
                '*APLICACIÓN AMASVENTAS.*\n *Una aplicación para al familia AmasZonas.*\n💬 Con  *AmaszVentas podrás: * \n 🔺 Notificaciones en línea. \n 🔺 Enterarte de las promociones. \n 🔺Inscribirte como promotor de ventas. \n🔺Venta de pasajes. \n 🔺 Compra de pasajes. 🔺 Mucho mas... \n📲 *Descargar la App en el siguiente enlace:* https://play.google.com/store/apps/details?id=bo.amaszonas',
                'text/html')),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.questionCircle,
              size: 25,
              color: AppTheme.themeGrey,
            ),
            '     Preguntas frecuentes',
            () => navegation(context, FaqPage())),
        CustomListTile(
            FaIcon(FontAwesomeIcons.commentAlt,
                size: 25, color: AppTheme.themeGreen),
            '    Acerca de la APP.',
            () => navegation(context, IntroPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.key,
              size: 25,
              color: Colors.pink,
            ),
            '   Cambiar Contraseña',
            () => navegation(context, ChangePasswordPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.home,
              size: 25,
            ),
            '    Cerrar Sesión',
            () => navegation(context, LogOnPage())),
      ],
    ));
  }
}
