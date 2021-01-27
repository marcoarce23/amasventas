import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:amasventas/src/crosscutting/StatusCode.dart';
import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';
import 'package:amasventas/src/service/exceptions/AbmException.dart';
import 'package:amasventas/src/service/exceptions/FetchDataException.dart';

class NotificationRepo {
  Future<Map<String, dynamic>> repository(BaseEntity entity) async {
    var result;
    switch (entity.states) {
      case StateEntity.Insert:
        result = await add(entity);
        break;
      case StateEntity.Update:
        result = await update(entity);
        break;
      case StateEntity.DeleteLogic:
     //   result = await delete(entity);
        break;
      case StateEntity.DeletePhysical:
        result = await deletePhysical(entity);
        break;
      default:
    }
    return result;
  }

  Future<Map<String, dynamic>> add(BaseEntity entity) async {
    print('EL xxxxxx');
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

  Future<Map<String, dynamic>> delete(String id) async {
    try {
      final apiRest = 'entity.apiUrl';
      final response = await http
          .post(apiRest, headers: {"Content-Type": "application/json"});
      return dataMap(response);
    } on AbmException {
      throw AbmException('Request Error');
    }
  }

  Future<Map<String, dynamic>> deletePhysical(BaseEntity entity) async {
    try {
      final apiRest = entity.apiUrl;
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
    //print('Response status: ${response.statusCode}');
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
}
