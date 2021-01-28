
import '../BaseEntity.dart';
import '../StateEntity.dart';

class ClasificadorModel extends BaseEntity {
  StateEntity states;
  int idClasificador;
  String nombre;
  int estado;

  ClasificadorModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new ClasificadorModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
