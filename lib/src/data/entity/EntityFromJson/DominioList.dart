import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';

class SucursalList extends BaseEntity {
  StateEntity states;
  String codSucursal;
  String nombreSucursal;

  SucursalList(
      {this.states = StateEntity.None,
      this.codSucursal,
      this.nombreSucursal});

  fromJson(Map<String, dynamic> json) => new SucursalList(
        codSucursal: json["cod_sucursal"],
        nombreSucursal: json["nombre_sucursal"],
      );
}

class JefeInmediatoList extends BaseEntity {
  StateEntity states;
  String usuario;
  String nombre;

  JefeInmediatoList(
      {this.states = StateEntity.None,
      this.usuario,
      this.nombre,
});

  fromJson(Map<String, dynamic> json) => new JefeInmediatoList(
        usuario: json["usuario"],
        nombre: json["nombre"],
      );
}

class DptoAreaList extends BaseEntity {
  StateEntity states;
  int idOrganigrama;
  String area;


  DptoAreaList(
      {this.states = StateEntity.None,
      this.idOrganigrama,
      this.area,
});

  fromJson(Map<String, dynamic> json) => new DptoAreaList(
        idOrganigrama: json["id_organigrama"],
        area: json["area"],
      );
}

class CargoList extends BaseEntity {
  StateEntity states;
  String codigo;
  String descripcion;

  CargoList(
      {this.states = StateEntity.None,
      this.codigo,
      this.descripcion,});

  fromJson(Map<String, dynamic> json) => new CargoList(
        codigo: json["codigo"],
        descripcion: json["descripcion"],
      );
}


class DominioList extends BaseEntity {
  StateEntity states;
  String codigo;
  String descripcion;

  DominioList(
      {this.states = StateEntity.None,
      this.codigo,
      this.descripcion,});

  fromJson(Map<String, dynamic> json) => new DominioList(
        codigo: json["codigo"],
        descripcion: json["descripcion"],
      );
}