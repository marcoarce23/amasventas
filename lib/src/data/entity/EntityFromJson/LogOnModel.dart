import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';

class LoginModel extends BaseEntity {
  StateEntity states;
  String usuario;
  String password;

  LoginModel({
    this.states = StateEntity.None,
    this.usuario,
    this.password,
  });

  fromJson(Map<String, dynamic> json) =>
      new LoginModel(usuario: json["usuario"], password: json["password"]);
}
