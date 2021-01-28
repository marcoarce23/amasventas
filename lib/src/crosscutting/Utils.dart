import 'package:flutter/material.dart';

final String userName = null;

String ejecutadoPorcent(double ejecutado, double programado) {
  var valor = (ejecutado / programado) * 100;
  return valor.round().toString() + '%';
}

double ejecutado(double ejecutado, double programado) {
  return ejecutado / programado;
}

//showPictureOval(ejecutadoPorcent(entity.anualEjecutado,entity.anualProgramado), 25, colorPorcent(entity.anualEjecutado,entity.anualProgramado), ejecutado(entity.anualEjecutado,entity.anualProgramado)),
Color colorPorcent(double ejecutado, double programado) {
  Color color = Colors.red;
  var valor = ejecutado / programado;
  if (valor >= 0 && valor <= 0.6) return Colors.green;
  if (valor > 0.6 && valor <= 0.8) return Colors.yellow;
  if (valor > 0.8 && valor <= 1) return Colors.red;

  if (valor >= 1) return Colors.black;
  return color;
}

String obtenerMunicipio(int idMunicipio) {
  String _departamento = 'Cochabamba';

  if (idMunicipio == 1) _departamento = 'Pando';
  if (idMunicipio == 2) _departamento = 'Beni';
  if (idMunicipio == 3) _departamento = 'Santa Cruz';
  if (idMunicipio == 4) _departamento = 'La Paz';
  if (idMunicipio == 5) _departamento = 'Oruro';
  if (idMunicipio == 6) _departamento = 'Potosi';
  if (idMunicipio == 7) _departamento = 'Cochabamba';
  if (idMunicipio == 8) _departamento = 'Tarija';
  if (idMunicipio == 9) _departamento = 'Chuquisaca';
  if (idMunicipio == 10) _departamento = 'Torno';
  if (idMunicipio == 11) _departamento = 'Sacaba';
  return _departamento;
}

// enviarNotificaciones(String urlGetToken, String clave, String titulo,
//     String valorTitulo, String subTitulo, String subTituloValor) {
//   Token entityToken;
//   final dataMapToken =
//       new Generic().getAll(new Token(), urlGetToken, primaryKeyGetToken);

//   dataMapToken.then((value) {
//     if (value.length > 0) {
//       for (int i = 0; i < value.length; i++) {
//         entityToken = value[i];
//         //    //print('entrooo las veces de: $entityToken');
//         new Generic().sebnFCM(entityToken.llaveToken, clave,
//             '$titulo - $valorTitulo - $subTitulo $subTituloValor - Fecha - ${DateTime.now()}');
//       }
//     }
//   });
// }

int daysInMonth(int month) {
  var now = DateTime.now();

  var lastDayDateTime = (month < 12)
      ? new DateTime(now.year, month + 1, 0)
      : new DateTime(now.year + 1, 1, 0);

  return lastDayDateTime.day;
}

// Future<LatLng> getLocation() async {
//   final Location location = Location();
//   LocationData location1;
//   LocationData locationResult;
//   try {
//     locationResult = await location.getLocation();
//   } on PlatformException catch (e) {
//     if (e.code == 'PERMISSION DENIED')
//       print('Permission denied');
//     else if (e.code == 'PERMISSION DENIED_NEVER_ASK')
//       print('Permission denied enable ask');
//   }
//   location1 = locationResult;
//   return LatLng(location1.latitude, location1.longitude);
// }
