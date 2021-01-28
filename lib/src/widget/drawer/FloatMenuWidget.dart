import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/page/amasventas/GraficaPage.dart';
import 'package:amasventas/src/page/faq/FaqPage.dart';
import 'package:amasventas/src/page/general/ViewPage.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/page/intro/IntroPage.dart';
import 'package:amasventas/src/page/personal/PersonalListPage.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/general/SenWidget.dart';
import 'package:amasventas/src/widget/general/SharedWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget boomMenu(BuildContext context) {
  return BoomMenu(
    backgroundColor: AppTheme.themeGreen,
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: IconThemeData(size: 22.0),
    child: Icon(Icons.add),
    onOpen: () => print('OPENING DIAL'),
    onClose: () => print('DIAL CLOSED'),
    scrollVisible: true,
    overlayColor: Colors.black,
    overlayOpacity: 0.7,
    children: [
      MenuItem(
        child: Icon(Icons.bar_chart_outlined, color: Colors.orange, size: 45),
        title: "Reporte Semestral",
        titleColor: AppTheme.themeBlackBlack,
        subtitle: "Revisa el Reporte Semestral.",
        subTitleColor: AppTheme.themeBlackBlack,
        backgroundColor: AppTheme.themeWhite,
        onTap: () => navegation(context, GraficaPage()), //PersonalListPage()),
      ),
      MenuItem(
        child: FaIcon(FontAwesomeIcons.facebook, size: 35, color: Colors.blue),
        title: "Visitanos en Facebook",
        titleColor: AppTheme.themeBlackBlack,
        subtitle: "Visita la página de Amaszonas en Facebook",
        subTitleColor: AppTheme.themeBlackBlack,
        backgroundColor: AppTheme.themeWhite,
        onTap: () => navegation(
            context,
            ViewPage(
                title: 'PAGINA OFICIAL DE AMASZONAS'.toString(),
                url: facebook)),
      ),
      MenuItem(
        child: FaIcon(FontAwesomeIcons.instagram, size: 35, color: Colors.red),
        title: "Visitanos en Instagram",
        titleColor: AppTheme.themeBlackBlack,
        subtitle: "Visita la página de Amaszonas en Instagram",
        subTitleColor: AppTheme.themeBlackBlack,
        backgroundColor: AppTheme.themeWhite,
        onTap: () => navegation(
            context,
            ViewPage(
                title: 'PAGINA OFICIAL DE AMASZONAS'.toString(),
                url: instagram)),
      ),
      MenuItem(
        child: FaIcon(FontAwesomeIcons.mailBulk,
            size: 35, color: Colors.redAccent),
        title: "Contacta a la familia Amaszonas",
        titleColor: AppTheme.themeBlackBlack,
        subtitle: "Si gustas comunicarte con nosotros contáctate",
        subTitleColor: AppTheme.themeBlackBlack,
        backgroundColor: AppTheme.themeWhite,
        onTap: () => sendEmailAdvanced(
            'amaszonas@amaszonas.com',
            'SRES. AMASZONAS DESEO COMUNICARME CON UDS.',
            'De mi consideración: \n\n Tengan un buen día. Deseo comunciarme con ustedes para poder conocer sobre información sobre Amasventas. \n\n Saludos cordiales.'),
      ),
      MenuItem(
        child: FaIcon(FontAwesomeIcons.shareAlt,
            size: 35, color: AppTheme.themeBlackGrey),
        title: "Compartir aplicación",
        titleColor: AppTheme.themeBlackBlack,
        subtitle: "Queremos que la familia crezca contigo.",
        subTitleColor: AppTheme.themeBlackBlack,
        backgroundColor: AppTheme.themeWhite,
        onTap: () => sharedText(
            'BIENVENIDO A AMASZVENTAS',
            '*APLICACIÓN AMASVENTAS.*\n *Una aplicación para al familia AmasZonas.*\n💬 Con  *AmaszVentas podrás: * \n 🔺 Notificaciones en línea. \n 🔺 Enterarte de las promociones. \n 🔺Inscribirte como promotor de ventas. \n🔺Venta de pasajes. \n 🔺 Compra de pasajes. 🔺 Mucho mas... \n📲 *Descargar la App en el siguiente enlace:* https://play.google.com/store/apps/details?id=bo.amaszonas',
            'text/html'),
      ),
      MenuItem(
        child: FaIcon(
          FontAwesomeIcons.questionCircle,
          size: 35,
          color: AppTheme.themeGrey,
        ),
        title: "Preguntas frecuentes",
        titleColor: AppTheme.themeBlackBlack,
        subtitle: "Estamos para aclararte las consultas.",
        subTitleColor: AppTheme.themeBlackBlack,
        backgroundColor: AppTheme.themeWhite,
        onTap: () => navegation(context, FaqPage()),
      ),
      MenuItem(
        child: FaIcon(FontAwesomeIcons.commentAlt,
            size: 35, color: AppTheme.themeGreen),
        title: "Acerca de la App",
        titleColor: AppTheme.themeBlackBlack,
        subtitle: "Conoce sobre nuestra APP.",
        subTitleColor: AppTheme.themeBlackBlack,
        backgroundColor: AppTheme.themeWhite,
        onTap: () => navegation(context, IntroPage()),
      ),
      MenuItem(
        child: Icon(Icons.home, color: AppTheme.themeWhite, size: 45),
        title: "Inicio a la APP.",
        titleColor: Colors.white,
        subtitle: "Si desea ir la inicio de la APP.",
        subTitleColor: AppTheme.themeWhite,
        backgroundColor: AppTheme.themeRed,
        onTap: () => navegation(context, HomePage()),
      )
    ],
  );
}
