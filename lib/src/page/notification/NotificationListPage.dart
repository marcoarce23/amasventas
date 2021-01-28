import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/NotificacionList.dart';
import 'package:amasventas/src/data/entity/EntityMap/NotificationModel.dart'
    as model;
import 'package:amasventas/src/data/entity/EntityMap/NotificationModel.dart';
import 'package:amasventas/src/repository/Repository.dart';

import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/card/CardVM.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/page/home/HomePage.dart';

class NotificationListPage extends StatefulWidget {
  static final String routeName = 'notificationList';
  NotificationListPage({Key key}) : super(key: key);

  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  //DEFINICION DE BLOC Y MODEL
  NotificacionModel entity = new NotificacionModel();
  model.NotificacionModel entityModel = new model.NotificacionModel();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = NotificationListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('NOTIFICACIONES'),
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
              //  backgroundBasic(context),
              Container(
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    sizedBox(0.0, 8),
                    showInformationBasic(
                      context,
                      'ADMINISTRA LAS NOTIFICACIONES',
                      'En esta pantalla puedes modificar y eliminar las notificaciones que haz creado anteriormente.',
                    ),
                    sizedBox(0.0, 3),
                    divider(),
                  ],
                ),
              ),
              futureBuilder(context),
              copyRigth(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatButtonImage(Colors.transparent, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
         future: new Repository().getData(new NotificacionList()),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return loading();
                break;
              default:
                return listView(context, snapshot);
            }
          } else {
            return loading();
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
          NotificacionModel entity = snapshot.data[index];

          return _showListTile(entity, context);
        },
      ),
    );
  }

  Widget _showListTile(NotificacionModel entity, BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            sizedBox(0, 7),
            CardVM(
              size: 140,
              imageAssets: 'assets/icono3.png',
              opciones: _simplePopup(
                  entity, entity.idNotificacion.toString(), context),
              accesosRapidos: null,
              listWidgets: [
            //    avatarCircleTransparent(IMAGE_DEFAULT, 40),
                sizedBox(0, 7),
                Text(
                  'TÍTULO : ${entity.titulo}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'DETALLE: ${entity.detalle}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                  // Text(
                  //     'PUBLICADO: ${entity.fechacreacion.substring(0, 10)}',
                  //     style: kSubtitleStyleWhite,
                  // softWrap: true,
                  // overflow: TextOverflow.clip,
                  // textAlign: TextAlign.justify,
                  //   ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _simplePopup(
          NotificacionModel entity, String keyId, BuildContext context) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Notificar"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Editar"),
          ),
          PopupMenuItem(
            value: 3,
            child: Text("Eliminar"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            case 1:
              showSnackbarWithOutKey("Por implementar", context);
              break;
            case 2:
              Navigator.pushNamed(context, 'notificationLoad',
                  arguments: entity);
              break;
            case 3:
              // entityModel.idNotificacion = int.parse(keyId);

              // _executeDelete(
              //   entityModel.idNotificacion.toString(),
              //   prefs.email,
              // );

              break;
            default:
              showSnackbarWithOutKey("No hay opcion seleccionada", context);
              break;
          }
        },
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        offset: Offset(0, 100),
      );

  // _executeDelete(String id, String usuario) async {
  //   try {
  //     await entityService.delete(id, usuario).then((result) {
  //       if (result["tipo_mensaje"] == '0') {
  //         setState(() {
  //           showSnackbar(STATUS_OK, scaffoldKey);
  //         });
  //       } else
  //         showSnackbar(STATUS_ERROR, scaffoldKey);
  //     });
  //   } catch (error) {
  //     showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
  //   }
  // }
} // FIN DE LA CLASE
