import 'package:amasventas/src/data/entity/BaseEntity.dart';

class VentasGastosList extends BaseEntity {
  double ventas;
  double gastos;

  VentasGastosList({
    this.ventas,
    this.gastos,
  });

  fromJson(Map<String, dynamic> json) => new VentasGastosList(
        ventas: json["ventas"],
        gastos: json["gastos"],
      );
}

class VentasGastosDetalleList extends BaseEntity {
  String icono;
  int idOrganigrama;
  String detalle;
  double anualProgramado;
  double anualEjecutado;
  double acumuladoProgramado;
  double acumuladoEjecutado;
  double mesProgramado;
  double mesEjecutado;

  VentasGastosDetalleList({
    this.icono,
    this.idOrganigrama,
    this.detalle,
    this.anualProgramado,
    this.anualEjecutado,
    this.acumuladoProgramado,
    this.acumuladoEjecutado,
    this.mesProgramado,
    this.mesEjecutado,
  });

  fromJson(Map<String, dynamic> json) => new VentasGastosDetalleList(
        icono: json["icono"],
        idOrganigrama: json["id_organigrama"],
        detalle: json["detalle"],
        anualProgramado: json["anual_programado"],
        anualEjecutado: json["anual_ejecutado"],
        acumuladoProgramado: json["acumulado_programado"],
        acumuladoEjecutado: json["acumulado_ejecutado"],
        mesProgramado: json["mensual_programado"],
        mesEjecutado: json["mensual_ejecutado"],
      );
}

class CmcAreaDetalleList extends BaseEntity {

  int idpresupuestogastodet;
  String gestion;
  String periodo;
  String area;
  String item;
  double programado;
  double ejecutado;
  double cumplimiento;

  CmcAreaDetalleList({
    this.idpresupuestogastodet,
    this.gestion,
    this.periodo,
    this.area,
    this.item,
    this.programado,
    this.ejecutado,
    this.cumplimiento,
  });

  fromJson(Map<String, dynamic> json) => new CmcAreaDetalleList(
        idpresupuestogastodet: json["id_presupuesto_gasto_det"],
        gestion: json["gestion"],
        periodo: json["periodo"],
        area: json["area"],
        item: json["item"],
        programado: json["programado"],
        ejecutado: json["ejecutado"],
        cumplimiento: json["cumplimiento"],
      );
}
