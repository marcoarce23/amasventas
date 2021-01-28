import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';

class MenuList extends BaseEntity {
  StateEntity states;
  String modulo;
  String descripcion;
  String valorCaracter;

  MenuList(
      {this.states = StateEntity.None,
      this.modulo,
      this.descripcion,
      this.valorCaracter});

  fromJson(Map<String, dynamic> json) => new MenuList(
        modulo: json["modulo"],
        descripcion: json["descripcion"],
        valorCaracter: json["valor_caracter"],
      );
}
