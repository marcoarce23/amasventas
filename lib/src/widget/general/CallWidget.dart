import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';

callWhatsApp1(int number) async {
  await FlutterOpenWhatsapp.sendSingleMessage("591" + number.toString(),
      "*VirtualMatch* :Hola, estas listo para jugar?");
}

callWhatsAppText(int number, String text) async {
  await FlutterOpenWhatsapp.sendSingleMessage("591" + number.toString(), text);
}

callWhatsAppAdvanced(String message) async {
  await FlutterOpenWhatsapp.sendSingleMessage('', message);
}

callNumber(int number) async {
  String message = 'No s epudo hacer la llamada';
  var url = 'tel:${number.toString()}';
  if (await canLaunch(url)) {
    await launch(url);
  }
  return message;
}
