import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';

class RolList extends BaseEntity {
  StateEntity states;
  String idRol;
  String rolNombre;

  RolList({
    this.states = StateEntity.None,
    this.idRol,
    this.rolNombre,
  });

  fromJson(Map<String, dynamic> json) =>
      new RolList(idRol: json["rol"], rolNombre: json["nombre_rol"]);
}
