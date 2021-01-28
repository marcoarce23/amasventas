import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/PersonaList.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/card/CardVM.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';

class PersonalListPage extends StatefulWidget {
  static final String routeName = 'personalList';
  PersonalListPage({Key key}) : super(key: key);

  @override
  _PersonalListPageState createState() => _PersonalListPageState();
}

class _PersonalListPageState extends State<PersonalListPage> {
  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PersonaList entityGet = new PersonaList();

  @override
  void initState() {
    prefs.lastPage = PersonalListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('PERFIL DE USUARIO'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/ico/ico.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              backgroundBasic(context),
              sizedBox(0.0, 8.0),
              Container(
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    showInformationBasic(
                      context,
                      'GESTIONA TU PERFIL',
                      'En esta pantalla puedes modificar tu perfil de  usuario.',
                    ),
                    sizedBox(0.0, 5.0),
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
      floatingActionButton: floatButton(AppTheme.themeGreen, context,
          FaIcon(FontAwesomeIcons.plane), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    entityGet.apiUrl =
        "http://amasventas.neuronatexnology.com/api/GetSeguridad/GetDatosContacto/" +
            prefs.nameUser;

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
          PersonaList entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(PersonaList entity) {
    return Column(
      children: <Widget>[
        sizedBox(0, 7.0),
        CardVM(
          size: 300,
          imageAssets: 'assets/icono3.png',
          opciones: _simplePopup(entity, context),
          accesosRapidos: null,
          listWidgets: [
            // avatarCircle(IMAGE_LOGO, 40),
            sizedBox(0, 7),
            // Text(
            //   'TÍTULO: ${entity.nombreCompleto}',
            //   style: kSubtitleStyleWhite,
            //   softWrap: true,
            //   overflow: TextOverflow.clip,
            //   textAlign: TextAlign.justify,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'NOMBRE COMPLETO: ${entity.nombreCompleto}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                sizedBox(0, 5),
                Text(
                  'APELLIDO PATERNO: ${entity.apellidoPaterno}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                sizedBox(0, 5),
                Text(
                  'APELLIDO MATERNO: ${entity.apellidoMaterno}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                sizedBox(0, 5),
                Text(
                  'NRO. DOCUMENTO: ${entity.nroDocumento}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                sizedBox(0, 5),
                Text(
                  'EMAIL: ${entity.email} ',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                sizedBox(0, 5),
                Text(
                  'CELULAR: ${entity.celular} ',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                sizedBox(0, 5),
                Text(
                  'SUCURSAL: ${entity.sucursal} ',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                sizedBox(0, 5),
                Text(
                  'JEFE INMEDIATO: ${entity.jefe_inmediato} ',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                sizedBox(0, 5),
                Text(
                  'AREA: ${entity.area} ',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                sizedBox(0, 5),
                Text(
                  'CARGO: ${entity.cargo} ',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _simplePopup(PersonaList entity, BuildContext context) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Editar Perfil"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            case 1:
              Navigator.pushNamed(context, 'personal', arguments: entity);
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

  void executeDelete(String id, String usuario) async {
    // try {
    //   await entityService.delete(id, usuario).then((result) {
    //     if (result["tipo_mensaje"] == '0') {
    //       setState(() {
    //         showSnackbar(STATUS_OK, scaffoldKey);
    //       });
    //     } else
    //       showSnackbar(STATUS_ERROR, scaffoldKey);
    //   });
    // } catch (error) {
    //   showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    // }
    // setState(() {});
  }
} // FIN DE LA CLASE
