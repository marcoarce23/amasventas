import 'package:amasventas/src/data/entity/BaseEntity.dart';

class PersonaList extends BaseEntity {
  String nombreCompleto;
  String apellidoPaterno;
  String apellidoMaterno;
  String nroDocumento;
  String email;
  String celular;
  String cod_sucursal;
  String sucursal;
  String cod_jefe_inmediato;
  String jefe_inmediato;
  int cod_area;
  String area;
  String cod_cargo;
  String cargo;

  PersonaList(
      {this.nombreCompleto,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.nroDocumento,
      this.email,
      this.cod_sucursal,
      this.sucursal,
      this.cod_jefe_inmediato,
      this.jefe_inmediato,
      this.cod_area,
      this.area,
      this.cod_cargo,
      this.cargo,
      this.celular});

  fromJson(Map<String, dynamic> json) => new PersonaList(
        nombreCompleto: json["nombre_completo"],
        apellidoPaterno: json["apellido_paterno"],
        apellidoMaterno: json["apellido_materno"],
        nroDocumento: json["nro_documento"],
        cod_sucursal: json["cod_sucursal"],
        sucursal: json["sucursal"],
        cod_jefe_inmediato: json["cod_jefe_inmediato"],
        jefe_inmediato: json["jefe_inmediato"],
        cod_area: json["cod_area"],
        area: json["area"],
        cod_cargo: json["cod_cargo"],
        cargo: json["cargo"],
        email: json["email"],
        celular: json["celular"],
      );
}
