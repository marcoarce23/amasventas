

import 'package:url_launcher/url_launcher.dart';

openWeb(String url) async {
  String message = 'Error al abrir la página';
  if (await canLaunch(url)) {
    await launch(url);
  }
  return message;
}
