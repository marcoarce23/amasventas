import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';

class LogOnModel extends BaseEntity {
  @override
  StateEntity states;
  String usuario;
  String contrasenia;

  LogOnModel({this.states = StateEntity.None, this.usuario, this.contrasenia});

  Map<String, dynamic> toJson() =>
      {"usuario": usuario, "password": contrasenia};
}

class LogOnADModel extends BaseEntity {
  @override
  StateEntity states;
  String usuario;
  String contrasenia;

  LogOnADModel(
      {this.states = StateEntity.None, this.usuario, this.contrasenia});

  Map<String, dynamic> toJson() =>
      {"usuario": usuario, "contrasenia": contrasenia};
}
