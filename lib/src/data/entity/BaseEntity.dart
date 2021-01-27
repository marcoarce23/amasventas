import 'package:amasventas/src/data/entity/StateEntity.dart';

class BaseEntity {
  StateEntity _state;
  String _apiUrl;

  StateEntity get states => _state;
  String get apiUrl => _apiUrl;

  // ignore: avoid_return_types_on_setters
  void set states(StateEntity statesEntity) {
    this._state = statesEntity;
  }

  // ignore: avoid_return_types_on_setters
  void set apiUrl(String api) {
    this._apiUrl = api;
  }

  // ignore: unused_element
  fromJson(Map<String, dynamic> json) => {};
  // ignore: unused_element
  Map<String, dynamic> toJson() => {};
}
