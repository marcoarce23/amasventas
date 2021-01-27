


import 'package:url_launcher/url_launcher.dart';

sendEmail(String email, String subject) async {
  String message = 'No s epudo enviar el correo';
  var url = 'mailto:$email?subject= $subject&';
  if (await canLaunch(url)) {
    await launch(url);
  }
  return message;
}

sendEmailAdvanced(String email, String subject, String body) async {
  String message = 'Problemas al enviar el correo, vuelva a intentarlo.';
  var url = 'mailto:$email?subject= $subject&body=$body';
  if (await canLaunch(url)) {
    await launch(url);
  }
  return message;
}

sendSMS(int number) async {
  String message = 'Problemas al enviar el correo, vuelva a intentarlo.';
  var url = 'sms:${number.toString()}';
  if (await canLaunch(url)) {
    await launch(url);
  }
  return message;
}