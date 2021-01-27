import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/image/imageOvalWidget.dart';
import 'package:amasventas/src/widget/util/Util.dart';

Future<File> loadImage(ImageSource image) async {
  final _foto = await ImagePicker().getImage(source: image)
      as File; // ESTO REVISAR SI DA ERROR

  print('uploadImage: $_foto');
  return _foto;
}

Widget showPictureRectangle(File file, String picture, double heigth) {
  if (picture != null) {
    return FadeInImage(
      image: NetworkImage(picture),
      placeholder: AssetImage('assets/jar-loading.gif'),
      height: heigth,
      fit: BoxFit.contain,
    );
  } else {
    return Image(
      image: AssetImage(file?.path ?? IMAGE_LOGO),
      height: heigth,
      fit: BoxFit.cover,
    );
  }
}

Widget showPictureOval(File file, String image, double heigth) {
  Container(
    width: 60.0,
    height: 60.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(22, 23, 22, 0.4)),
  );

  return Stack(
    children: <Widget>[
      // Positioned(top: 90.0, left: 30.0, child: circulo),
      // Positioned(top: 20.0, right: 30.0, child: circulo),
      // Positioned(bottom: -50.0, right: -10.0, child: circulo),
      // Positioned(bottom: 120.0, right: 20.0, child: circulo),
      // Positioned(bottom: -50.0, left: -20.0, child: circulo),
      Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            Align(
              child: RadialProgress(
                progressColor: Colors.purple,
                progressBackgroundColor: AppTheme.themeDefault,
                width: 4,
                goalCompleted: 0.85,
                child: Container(
                  child: ImageOvalNetwork(
                      imageNetworkUrl: image, sizeImage: Size.fromWidth(90)),
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget showPictureOvalTop(File file, String image, double heigth, double top) {
  Container(
    width: 60.0,
    height: 60.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(22, 23, 22, 0.4)),
  );

  return Stack(
    children: <Widget>[
      // Positioned(top: 90.0, left: 30.0, child: circulo),
      // Positioned(top: 20.0, right: 30.0, child: circulo),
      // Positioned(bottom: -50.0, right: -10.0, child: circulo),
      // Positioned(bottom: 120.0, right: 20.0, child: circulo),
      // Positioned(bottom: -50.0, left: -20.0, child: circulo),
      Container(
        padding: EdgeInsets.only(top: top),
        child: Column(
          children: <Widget>[
            Align(
              child: RadialProgress(
                progressColor: Colors.purple,
                progressBackgroundColor: AppTheme.themeDefault,
                width: 4,
                goalCompleted: 0.85,
                child: Container(
                    child: ImageOvalNetwork(
                        imageNetworkUrl: image, sizeImage: Size.fromWidth(90))),
              ),
            ),
          ],
        ),
      )
    ],
  );
}
