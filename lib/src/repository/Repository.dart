import 'dart:convert';
import 'package:amasventas/src/data/entity/EntityFromJson/RendimientoModel.dart';
import 'package:http/http.dart' as http;
import 'package:amasventas/src/crosscutting/StatusCode.dart';
import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';
import 'package:amasventas/src/service/exceptions/AbmException.dart';
import 'package:amasventas/src/service/exceptions/FetchDataException.dart';

class Repository {
  Future<Map<String, dynamic>> repository(BaseEntity entity) async {
    var result;
    switch (entity.states) {
      case StateEntity.Insert:
        result = await add(entity);
        break;
      case StateEntity.Update:
        result = await update(entity);
        break;
      default:
    }
    return result;
  }

  Future<Map<String, dynamic>> add(BaseEntity entity) async {
    try {
      String _body = json.encode(entity.toJson());
      print('EL xxxxxx: $_body');
      print('EL URLLLLL: ${entity.apiUrl}');
      final response = await http.post(entity.apiUrl,
          headers: {"Content-Type": "application/json"}, body: _body);
      return dataMap(response);
    } on AbmException {
      throw AbmException('Request Error');
    }
  }

  Future<Map<String, dynamic>> update(BaseEntity entity) async {
    try {
      String _body = json.encode(entity.toJson());
      final apiRest = entity.apiUrl;
      final response = await http.post(apiRest,
          headers: {"Content-Type": "application/json"}, body: _body);
      return dataMap(response);
    } on AbmException {
      throw AbmException('Request Error');
    }
  }

  Future<Map<String, dynamic>> delete(String url, String usuario) async {
    try {
      final apiRest = url;
      final response = await http
          .delete(apiRest, headers: {"Content-Type": "application/json"});
      return dataMap(response);
    } on AbmException {
      throw AbmException('Request Error');
    }
  }


  Future<Map<String, dynamic>> getDataMap(BaseEntity entity) async {
    try {
      final apiRest = entity.apiUrl;
      final response = await http.get(apiRest);
      return dataMap(response);
    } on FetchDataException {
      throw FetchDataException('Request Error');
    }
  }

  Future<List<BaseEntity>> getList(BaseEntity entity) async {
    try {
      final List<BaseEntity> list = new List();
      Map<String, dynamic> decodeData;

      final apiRest = entity.apiUrl;
      final response = await http.get(apiRest);

      if (response.statusCode == 200) {
        Map dataMap = json.decode(response.body);
        List<dynamic> listDynamic = dataMap['data'];
        for (int i = 0; i < listDynamic.length; i++) {
          decodeData = listDynamic[i];
          list.add(entity.fromJson(decodeData));
        }
      } else {
        FetchDataException('Error: Status 400');
      }
      return list;
    } on FetchDataException {
      throw FetchDataException('Request Error');
    }
  }

  Map dataMap(http.Response response) {
    Map dataMap;
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == STATUSCODE200)
      dataMap = json.decode(response.body);
    else if (response.statusCode == STATUSCODE400)
      dataMap = json.decode(response.body);
    else
      throw Exception(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    return dataMap;
  }

  Future<List<BaseEntity>> getData(BaseEntity entity) async {
    print('xxx data: ${entity.apiUrl}');
    try {
      final List<BaseEntity> list = new List();
      Map<String, dynamic> decodeData;
      final response = await http.get(entity.apiUrl);

      print('response: $response');

      if (response.statusCode == 200) {
        List<dynamic> listDynamic = json.decode(response.body)['data'];
        //List<dynamic> listDynamic = json.decode(response.body);
        for (int i = 0; i < listDynamic.length; i++) {
          decodeData = listDynamic[i];
          list.add(entity.fromJson(decodeData));
        }
      } else {
        FetchDataException('Error: Status 400');
      }
      return list;
    } on FetchDataException {
      throw FetchDataException('Request Error');
    }
  }

  Future<List<RendimientoList>> getDataRendimientoList(
      RendimientoList entity) async {
    print('xxx data: ${entity.apiUrl}');
    try {
      final List<RendimientoList> list = new List();
      Map<String, dynamic> decodeData;
      final response = await http.get(entity.apiUrl);

      print('response: $response');

      if (response.statusCode == 200) {
        List<dynamic> listDynamic = json.decode(response.body)['data'];
        //List<dynamic> listDynamic = json.decode(response.body);
        for (int i = 0; i < listDynamic.length; i++) {
          decodeData = listDynamic[i];
          list.add(entity.fromJson(decodeData));
        }
      } else {
        FetchDataException('Error: Status 400');
      }
      return list;
    } on FetchDataException {
      throw FetchDataException('Request Error');
    }
  }

   Future<List<SimuladorList>> getDataSimuladorList(
      SimuladorList entity) async {
    print('xxx data: ${entity.apiUrl}');
    try {
      final List<SimuladorList> list = new List();
      Map<String, dynamic> decodeData;
      final response = await http.get(entity.apiUrl);

      print('response: $response');

      if (response.statusCode == 200) {
        List<dynamic> listDynamic = json.decode(response.body)['data'];
        //List<dynamic> listDynamic = json.decode(response.body);
        for (int i = 0; i < listDynamic.length; i++) {
          decodeData = listDynamic[i];
          list.add(entity.fromJson(decodeData));
        }
      } else {
        FetchDataException('Error: Status 400');
      }
      return list;
    } on FetchDataException {
      throw FetchDataException('Request Error');
    }
  }

}
