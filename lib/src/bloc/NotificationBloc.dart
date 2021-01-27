import 'dart:async';

import 'package:amasventas/src/data/entity/EntityFromJson/NotificacionModel.dart';
import 'package:amasventas/src/data/entity/EntityMap/NotificationModel.dart'
    as map;
import 'package:amasventas/src/repository/NotificationRepo.dart';
import 'package:amasventas/src/service/exceptions/AbmException.dart';
import 'package:amasventas/src/service/responses/ResponsesService.dart';

class NotificationBloc {
  NotificationRepo _repository = NotificationRepo();
  StreamController _listController;

  StreamSink<ResponsesService<NotificacionList>> get notifyListSink =>
      _listController.sink;
  Stream<ResponsesService<NotificacionList>> get notifyListStream =>
      _listController.stream;

  NotificationBloc() {
    _listController = StreamController<ResponsesService<NotificacionList>>();
    // _repository = NotificationRepo();
  }

  getAllNotify(NotificacionList entity) async {
    notifyListSink.add(ResponsesService.loading('Fetching notify list'));
    try {
      //   List<NotificacionList> listEntity =
      //      await _repository.getAllNotifyList(entity);
      // notifyListSink.add(ResponsesService.completed(listEntity));
    } catch (e) {
      notifyListSink.add(ResponsesService.error(e.toString()));
      print(e);
    }
  }

  Future<Map<String, dynamic>> add(map.NotificacionModel entity) async {
    try {
      Future<Map<String, dynamic>> dataMap = _repository.add(entity);
      return dataMap;
    } catch (e) {
      print(e);
      throw AbmException(
          'Error occured while Communication with Server with StatusCode : ');
    }
  }

  // Future<Map<String, dynamic>> delete(map.NotificacionModel entity) async {
  //   try {
  //     Future<Map<String, dynamic>> dataMap = _repository.delete(entity);
  //     return dataMap;
  //   } catch (e) {
  //     print(e);
  //     throw AbmException(
  //         'Error occured while Communication with Server with StatusCode : ');
  //   }
  // }

  dispose() {
    _listController?.close();
  }
}
