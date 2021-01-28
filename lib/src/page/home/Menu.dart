import 'dart:ui';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/MenuList.dart';
import 'package:amasventas/src/page/amasventas/GraficaPage.dart';
import 'package:amasventas/src/page/amasventas/VentaPage.dart';
import 'package:amasventas/src/page/amasventas/simuladorVentasPage.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/widget/drawer/FloatMenuWidget.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';
import 'package:flutter/material.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';

class MenuPage extends StatefulWidget {
  static final String routeName = 'menu';
  final String opt;
  MenuPage({Key key, @required this.opt}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // RolList entity = new RolList();

  MenuList entity = new MenuList();
  Repository repo = new Repository();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = MenuPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    entity.apiUrl =
        'http://amasventas.neuronatexnology.com/api/GetSeguridad/GetMenusModuloUsuariosMobileRol/${prefs.nameUser}/modulo/${widget.opt}';

    // UserApi().apiRol(prefs.nameUser);
    // final size = MediaQuery.of(context).size;
    print('MENUUUUU POSTMMA ${entity.apiUrl}');
    return Scaffold(
      // key: scaffoldKey,
      appBar: appBar('AMASZONAS DIGITAL'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              color: Color.fromRGBO(242, 242, 242, 1),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  sizedBox(30.0, 10),
                  Text('MENU DEL SISTEMA - ${widget.opt}',
                      style: kTitleStyleBlack, textAlign: TextAlign.left),
                  // showInformationBasic(
                  //   context,
                  //   'MENU',
                  //   'CON EL ROL',
                  // ),
                  sizedBox(0.0, 3),
                  _futureBuilder(context),
                  copyRigthBlack(),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: boomMenu(context),
    );
  }

  Widget _futureBuilder(BuildContext context) {
    print('link: ${entity.apiUrl}');
    return FutureBuilder(
        future: repo.getData(entity),
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
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        MenuList entity = snapshot.data[index];

        return _showListTile(entity, context);
      },
    );
  }

  Widget _showListTile(MenuList entity, BuildContext context) {
    print('EEEE: ${entity.modulo}');
    if (entity.modulo == '6000') {
      return InkWell(
        onTap: () => navegation(context,
            VentaPage()), // SimuladorVentasPage()), // navegation(context,VentaPage()),
        child: Container(
          child: Column(
            children: <Widget>[
              sizedBox(0, 7.0),
              showInformationMenu(
                context,
                entity.descripcion,
                'Puedes ingresar a la siguiente opción',
                entity.valorCaracter,
              ),
            ],
          ),
        ),
      );
    }
    if (entity.modulo == '7000') {
      return InkWell(
        onTap: () => navegation(context,
            SimuladorVentasPage()), // SimuladorVentasPage()), // navegation(context,VentaPage()),
        // GraficaPage()),
        child: Container(
          child: Column(
            children: <Widget>[
              sizedBox(0, 7.0),
              showInformationMenu(
                context,
                entity.descripcion,
                'Puedes ingresar a la siguiente opción',
                entity.valorCaracter,
              ),
            ],
          ),
        ),
      );
    }

    if (entity.modulo == '8000') {
      return InkWell(
        onTap: () => navegation(context,
            GraficaPage()), // SimuladorVentasPage()), // navegation(context,VentaPage()),
        // GraficaPage()),
        child: Container(
          child: Column(
            children: <Widget>[
              sizedBox(0, 7.0),
              showInformationMenu(
                context,
                entity.descripcion,
                'Puedes ingresar a la siguiente opción',
                entity.valorCaracter,
              ),
            ],
          ),
        ),
      );
    }
  }
}
