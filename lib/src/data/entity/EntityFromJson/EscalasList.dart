import 'package:amasventas/src/data/entity/BaseEntity.dart';

class EscalaList extends BaseEntity {
  int codEscala;
  String nombreEscala;
  String tipoEscala;
  String descEscala;
  String descTipo;
  String descTipoEscala;
  String estado;
  String descEstado;
  String fechaCreacion;

  EscalaList(
      {this.codEscala,
      this.nombreEscala,
      this.tipoEscala,
      this.descTipoEscala,
      this.descTipo,
      this.estado,
      this.descEstado,
      this.fechaCreacion});

  fromJson(Map<String, dynamic> json) => new EscalaList(
        codEscala: json["cod_escala"],
        nombreEscala: json["nombre_escala"],
        tipoEscala: json["tipo_escala"],
        descTipoEscala: json["desc_tipo_escala"],
        descTipo: json["desc_tipo"],
        estado: json["estado"],
        descEstado: json["desc_estado"],
        fechaCreacion: json["fecha_creacion"],
      );
}
