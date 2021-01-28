import 'dart:convert';
import 'dart:io';
import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/crosscutting/StatusCode.dart';
import 'package:amasventas/src/repository/IApiUpload.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class ImageService {
  // Stream<List<EventModel>> get eventStream => _controller.stream;
  // Stream<bool> get loading => _loadingController.stream;

  dynamic respData(http.Response resp) {
    if (resp.statusCode != STATUSCODE200 && resp.statusCode != STATUSCODE201) {
      print('Algo salio mal IMAGENNNN ${resp.body}');
      return 'Algo salio mal PDF ${resp.body}';
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData[SECURE_URL];
  }

  Future<String> uploadImageFile(File imagen) async {
    final url = Uri.parse(URL_CLOUDY);
    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    // if (resp.statusCode != STATUSCODE200 && resp.statusCode != STATUSCODE201) {
    //   print('Algo salio mal IMAGENNNN ${resp.body}');
    return respData(resp);
    // }

    //   final respData = json.decode(resp.body);
    // print(respData);
    // return respData[SECURE_URL];
  }

  Future<String> uploadImage(String imagen) async {
    final url = Uri.parse(ApiCloudy().api());
    final mimeType = mime(imagen).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    // if (resp.statusCode != STATUSCODE200 && resp.statusCode != STATUSCODE201) {
    //   print('Algo salio mal PDF ${resp.body}');
    //   return 'Algo salio mal PDF ${resp.body}';
    // }

    // final respData = json.decode(resp.body);
    // print(respData);
    // return respData[SECURE_URL];
    return respData(resp);
  }

  Future<String> uploadVideo(String imagen) async {
    final url = Uri.parse(URL_CLOUDY);

    final mimeType = mime(imagen).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    return respData(resp);
    // if (resp.statusCode != STATUSCODE200 && resp.statusCode != STATUSCODE201) {
    //   print('Algo salio mal videooo ${resp.body}');
    //   return 'Algo salio mal PDF ${resp.body}';
    // }

    // final respData = json.decode(resp.body);
    // print(respData);
    // return respData[SECURE_URL];
  }
}
