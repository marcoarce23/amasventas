import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';

class LoginModel extends BaseEntity {
  @override
  StateEntity states;
  String foto;
  String nombre;
  String correo;
  String imei;
  String token;

  LoginModel(
      {this.states = StateEntity.None,
      this.foto,
      this.nombre,
      this.correo,
      this.imei,
      this.token});

  Map<String, dynamic> toJson() => {
        "foto": foto,
        "nombre": nombre,
        "correo": correo,
        "imei": imei,
        "token": token,
      };
}
