import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/crosscutting/StatusCode.dart';
import 'package:amasventas/src/data/entity/EntityFromJson/MultimediaModel.dart';
import 'package:amasventas/src/repository/Repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/appBar/AppBarWidget.dart';
import 'package:amasventas/src/widget/card/CardVM.dart';
import 'package:amasventas/src/widget/drawer/DrawerWidget.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';

class MultimediaListPage extends StatefulWidget {
  static final String routeName = 'multimediaList';
  MultimediaListPage({Key key}) : super(key: key);

  @override
  _MultimediaListPageState createState() => _MultimediaListPageState();
}

class _MultimediaListPageState extends State<MultimediaListPage> {
  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  MultimediaList entityGet = new MultimediaList();

  @override
  void initState() {
    prefs.lastPage = MultimediaListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // entityService = Provider.of<NewService>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('IMÁGENES MULTIMEDIA'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Container(
          //  color: Colors.black87,
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
                      'IMÁGENES MULTIMEDIA',
                      'Observa nuestra galería de imágenes.',
                    ),
                    sizedBox(0.0, 2.0),
                    dividerGreen(),
                  ],
                ),
              ),
              futureBuilder(context),
              copyRigthBlack(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatButton(AppTheme.themeGreen, context,
          FaIcon(FontAwesomeIcons.plane), HomePage()),

      // floatButton(AppTheme.themeDefault, context,
      //   FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    entityGet.apiUrl =
        "http://virtualmatch.neuronatexnology.com/api/Multimedia";
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
          MultimediaList entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(MultimediaList entity) {
    return Column(
      children: <Widget>[
        CardVM(
          size: 220,
          imageAssets: 'assets/icono3.png',
          opciones: _simplePopup(entity, entity.idMultimedia.toString()),
          accesosRapidos: null,
          listWidgets: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                avatarCircle(entity.foto, 55),
                sizedBox(0, 7),
                Text(
                  'TITULO: ${entity.titulo}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'RESUMEN: ${entity.resumen}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),

                // Text(
                //   'NOTICIA/EVENTO: ${entity.idaCategoria}',
                //   style: kSubtitleStyleWhite,
                //   softWrap: true,
                //   overflow: TextOverflow.clip,
                //   textAlign: TextAlign.justify,
                // ),
                Text(
                  'FECHA PUBLICACIÓN:  ${entity.fechainicio}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'FECHA FIN     :  ${entity.fechafin}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _simplePopup(MultimediaList entity, String keyId) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          // PopupMenuItem(
          //   value: 1,
          //   child: Text("Editar"),
          // ),
          PopupMenuItem(
            value: 1,
            child: Text("Eliminar"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            // case 1:
            //   Navigator.pushNamed(context, 'multimedia', arguments: entity);
            //   break;
            case 1:
              executeDelete(
                  entity.idMultimedia.toString(), 'marcoarce23@gmail.com');
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
    print('IDDD: $id');
    String url='http://virtualmatch.neuronatexnology.com/api/Multimedia/$id/usuario/$usuario';

    try {
      await new Repository().delete(url, usuario).then((result) {
        if (result["tipo_mensaje"] == '0')
          setState(() {
            showSnackbar('Se eliminó el registro con existo.!', scaffoldKey);
          });
        else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
    //   setState(() {});
  }
} // FIN DE LA CLASE
