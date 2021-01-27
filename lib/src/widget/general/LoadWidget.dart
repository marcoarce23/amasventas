import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

loadPDF(String path) async {
  var response = await http.get(path);

  var dir = await getApplicationDocumentsDirectory();
  File file = new File("${dir.path}/data.pdf");
  file.writeAsBytesSync(response.bodyBytes, flush: true);
  return file.path;
}