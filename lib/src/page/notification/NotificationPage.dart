import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/NotificacionList.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';

class NotificationPage extends StatefulWidget {
  static final String routeName = 'notificationPage';
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  //DEFINICION DE BLOC Y MODEL
  NotificacionList entityGet = new NotificacionList();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();

  @override
  void initState() {
    prefs.lastPage = NotificationPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // entityService = Provider.of<NotificationService>(context);
    return Scaffold(
      appBar: appBar('AMASZVENTAS 24/7.'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/portada2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              backgroundBasic(context),
              Container(
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                // decoration: boxDecoration(),
                child: Column(
                  children: <Widget>[
                    sizedBox(0, 10),
                    showInformationBasic(
                      context,
                      'TE MANTENEMOS INFORMADO?',
                      'Las noticias y eventos más importantes y de primera mano. Amaszonas Digital 24/7.',
                    ),
                  ],
                ),
              ),
              dividerGreen(),
              futureBuilder(context),
              copyRigthBlack(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatButton(AppTheme.themeGreen, context,
          FaIcon(FontAwesomeIcons.plane), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    entityGet.apiUrl =
        "http://virtualmatch.neuronatexnology.com/api/Notificacion";

    return FutureBuilder(
        future: new Repository().getData(entityGet),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listView(context, snapshot);
          }
        });
  }

  Widget listView(BuildContext context, AsyncSnapshot snapshot) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          NotificacionList entity = snapshot.data[index];

          return _showListTile(entity, context);
        },
      ),
    );
  }

  Widget _showListTile(NotificacionList entity, BuildContext context) {
    return Column(children: <Widget>[
      sizedBox(0, 5),
      showInformationBasic(
        context,
        'NOTIFICACIÓN : ${entity.titulo}',
        'DETALLE : ${entity.detalle}',
      ),
    ]);
  }
}
