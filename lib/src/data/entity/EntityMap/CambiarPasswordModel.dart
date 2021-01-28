
import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';

class CambiarPasswordModel extends BaseEntity {
  @override
  StateEntity states;
  String usuario;
  String password;
  String nuevopassword;


  CambiarPasswordModel(
      {this.states = StateEntity.None,
      this.usuario,
      this.password,
      this.nuevopassword});

  Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "passwordAnterior": password,
        "passwordNuevo": nuevopassword
      };
}