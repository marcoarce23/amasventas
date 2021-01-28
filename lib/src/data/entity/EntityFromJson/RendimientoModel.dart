import 'package:amasventas/src/data/entity/BaseEntity.dart';

class RendimientoList extends BaseEntity {
  String usuario;
  String estado;
  String mensaje;
  // ignore: non_constant_identifier_names
  String nombreCompleto;
  double limite;
  double pocentaje;
  double comision;
  // ignore: non_constant_identifier_names
  double montoVendido;
  double ponderacionKPI;
  double comisionKPI;
  double totalComision;
  double porcentajeKPI;
  String color;
  String moneda;

  double vd_kpiare;
  double vd_kpidep;
  double vd_kpipun;
  double vd_kpipre;
  double vd_kpiemp;

  String presupuesto;
  String puntualidad;
  String depto;
  String area;
  String personal;
  String empresa;

  String valorPresupuesto;
  String valorPuntualidad;
  String valorDepto;
  String valorArea;
  String valorPersonal;

  double porcentajePresupuesto;
  double porcentajePuntualidad;
  double porcentajeDepto;
  double porcentajeArea;
  double porcentajePersonal;

    List<Lista3> list3;
  List<Lista2> list2;


  RendimientoList({
    this.usuario,
    this.estado,
    this.mensaje,
    this.nombreCompleto,
    this.limite,
    this.pocentaje,
    this.comision,
    this.montoVendido,
    this.ponderacionKPI,
    this.comisionKPI,
    this.totalComision,
    this.porcentajeKPI,
    this.color,
    this.moneda,
    this.vd_kpiare,
    this.vd_kpidep,
    this.vd_kpiemp,
    this.vd_kpipre,
    this.vd_kpipun,
    this.presupuesto,
    this.puntualidad,
    this.depto,
    this.area,
    this.personal,
    this.empresa,
    this.valorPresupuesto,
    this.valorPuntualidad,
    this.valorDepto,
    this.valorArea,
    this.valorPersonal,
    this.porcentajePresupuesto,
    this.porcentajePuntualidad,
    this.porcentajeDepto,
    this.porcentajeArea,
    this.porcentajePersonal,
     this.list3,
    this.list2});

  fromJson(Map<String, dynamic> json) => new RendimientoList(
        usuario: json["usuario"],
        estado: json["estado"],
        mensaje: json["mensaje"],
        nombreCompleto: json["nombre_completo"],
        limite: json["limite"],
        comision: json["comision"],
        montoVendido: json["monto_vendido"],
        ponderacionKPI: double.parse(json["ponderacionKPI"].toString()),
        comisionKPI: json["comisionKPI"],
        pocentaje: double.parse(json["pocentaje"].toString()),
        totalComision: json["totalComision"],
        porcentajeKPI: json["porcentajeKPI"],
        color: json["color"],
        moneda: json["moneda"],
        vd_kpiare: json["vd_kpiare"],
        vd_kpidep: json["vd_kpidep"],
        vd_kpiemp: json["vd_kpiemp"],
        vd_kpipre: json["vd_kpipre"],
        vd_kpipun: json["vd_kpipun"],
        presupuesto: json["presupuesto"],
        puntualidad: json["puntualidad"],
        depto: json["depto"],
        area: json["area"],
        personal: json["personal"],
        empresa: json["empresa"],
        valorPresupuesto: json["valorPresupuesto"],
        valorPuntualidad: json["valorPuntualidad"],
        valorDepto: json["valorDepto"],
        valorArea: json["valorArea"],
        valorPersonal: json["valorPersonal"],
        porcentajePresupuesto: json["porcentajePresupuesto"],
        porcentajePuntualidad: json["porcentajePuntualidad"],
        porcentajeDepto: json["porcentajeDepto"],
        porcentajeArea: json["porcentajeArea"],
        porcentajePersonal: json["porcentajePersonal"],
          list2: json["lista2"] == null
            ? null
            : List<Lista2>.from(
                json["lista2"].map((x) => new Lista2().fromJson(x))),
        list3: json["lista3"] == null
            ? null
            : List<Lista3>.from(
                json["lista3"].map((x) => new Lista3().fromJson(x))),
      );
     
}

class SimuladorList extends BaseEntity {
  String usuario;
  String estado;
  String mensaje;
  // ignore: non_constant_identifier_names
  String nombreCompleto;
  double limite;
  double pocentaje;
  double comision;
  // ignore: non_constant_identifier_names
  double montoVendido;
  double ponderacionKPI;
  double comisionKPI;
  double totalComision;
  double porcentajeKPI;
  String color;
  String moneda;

  double vd_kpiare;
  double vd_kpidep;
  double vd_kpipun;
  double vd_kpipre;
  double vd_kpiemp;

  String presupuesto;
  String puntualidad;
  String depto;
  String area;
  String personal;
  String empresa;

  String valorPresupuesto;
  String valorPuntualidad;
  String valorDepto;
  String valorArea;
  String valorPersonal;

  double vdAREPp;
  double vdDEPPp;
  double vdPUNPp;
  double vdPREPp;
  double vdEMPPp;

  String pvPER;
  String pvARE;
  String pvDEP;
  String pvPUN;
  String pvPRE;
  String pvEMP;

 String pvPERL;
  String pvAREL;
  String pvDEPL;
  String pvPUNL;
  String pvPREL;
  String pvEMPL;

  List<Lista3> list3;
  List<Lista2> list2;

  SimuladorList(
      {this.usuario,
      this.estado,
      this.mensaje,
      this.nombreCompleto,
      this.limite,
      this.pocentaje,
      this.comision,
      this.montoVendido,
      this.ponderacionKPI,
      this.comisionKPI,
      this.totalComision,
      this.porcentajeKPI,
      this.color,
      this.moneda,
      this.vd_kpiare,
      this.vd_kpidep,
      this.vd_kpiemp,
      this.vd_kpipre,
      this.vd_kpipun,
      this.presupuesto,
      this.puntualidad,
      this.depto,
      this.area,
      this.personal,
      this.empresa,
      this.valorPresupuesto,
      this.valorPuntualidad,
      this.valorDepto,
      this.valorArea,
      this.valorPersonal,
      this.vdAREPp,
      this.vdDEPPp,
      this.vdPUNPp,
      this.vdPREPp,
      this.vdEMPPp,
      this.pvPER,
      this.pvARE,
      this.pvDEP,
      this.pvPUN,
      this.pvPRE,
      this.pvEMP,
    this.pvPERL,
      this.pvAREL,
      this.pvDEPL,
      this.pvPUNL,
      this.pvPREL,
      this.pvEMPL,
      this.list3,
      this.list2});

  fromJson(Map<String, dynamic> json) => new SimuladorList(
        usuario: json["usuario"],
        estado: json["estado"],
        mensaje: json["mensaje"],
        nombreCompleto: json["nombre_completo"],
        limite: json["limite"],
        comision: json["comision"],
        montoVendido: json["monto_vendido"],
        ponderacionKPI: double.parse(json["ponderacionKPI"].toString()),
        comisionKPI: json["comisionKPI"],
        pocentaje: double.parse(json["pocentaje"].toString()),
        totalComision: json["totalComision"],
        porcentajeKPI: json["porcentajeKPI"],
        color: json["color"],
        moneda: json["moneda"],
        vd_kpiare: json["vd_kpiare"],
        vd_kpidep: json["vd_kpidep"],
        vd_kpiemp: json["vd_kpiemp"],
        vd_kpipre: json["vd_kpipre"],
        vd_kpipun: json["vd_kpipun"],
        presupuesto: json["presupuesto"],
        puntualidad: json["puntualidad"],
        depto: json["depto"],
        area: json["area"],
        personal: json["personal"],
        empresa: json["empresa"],
        valorPresupuesto: json["valorPresupuesto"],
        valorPuntualidad: json["valorPuntualidad"],
        valorDepto: json["valorDepto"],
        valorArea: json["valorArea"],
        valorPersonal: json["valorPersonal"],
        vdAREPp: json["vd_AREPp"],
        vdDEPPp: json["vd_DEPPp"],
        vdPUNPp: json["vd_PUNPp"],
        vdPREPp: json["vd_PREPp"],
        vdEMPPp: json["vd_EMPPp"],
        pvPER: json["pv_PER"],
        pvARE: json["pv_ARE"],
        pvDEP: json["pv_DEP"],
        pvPUN: json["pv_PUN"],
        pvPRE: json["pv_PRE"],
        pvEMP: json["pv_EMP"],

pvPERL: json["pv_PERL"],
        pvAREL: json["pv_AREL"],
        pvDEPL: json["pv_DEPL"],
        pvPUNL: json["pv_PUNL"],
        pvPREL: json["pv_PREL"],
        pvEMPL: json["pv_EMPL"],
        list2: json["lista2"] == null
            ? null
            : List<Lista2>.from(
                json["lista2"].map((x) => new Lista2().fromJson(x))),
        list3: json["lista3"] == null
            ? null
            : List<Lista3>.from(
                json["lista3"].map((x) => new Lista3().fromJson(x))),
      );
}

class RendimientoDetalleList extends BaseEntity {
  String pregunta;
  double ponderacion;

  RendimientoDetalleList({
    this.pregunta,
    this.ponderacion,
  });

  fromJson(Map<String, dynamic> json) => new RendimientoDetalleList(
        pregunta: json["pregunta"],
        ponderacion: double.parse(json["ponderacion"].toString()),
      );
}

class RendimientoKPIList extends BaseEntity {
  String valor;
  String puntosRango;
  String puntuacion;
  int desde;
  int hasta;
  int orden;

  RendimientoKPIList({
    this.valor,
    this.puntosRango,
    this.puntuacion,
    this.desde,
    this.hasta,
    this.orden,
  });

  fromJson(Map<String, dynamic> json) => new RendimientoKPIList(
        valor: json["valor"],
        puntosRango: json["puntosRango"],
        puntuacion: json["puntuacion"],
        desde: int.parse(json["desde"].toString()),
        hasta: int.parse(json["hasta"].toString()),
        orden: int.parse(json["orden"].toString()),
      );
}

class Lista3 extends BaseEntity {
  String detalle;
  double presupuestado;
  double ejecutado;

  Lista3({
    this.detalle,
    this.presupuestado,
    this.ejecutado,
  });

  fromJson(Map<String, dynamic> json) => new Lista3(
        detalle: json["detalle"],
        presupuestado: json["presupuestado"],
        ejecutado: json["ejecutado"],
      );
}

class Lista2 extends BaseEntity {
  String detalle;
  double presupuestado;
  double ejecutado;

  Lista2({
    this.detalle,
    this.presupuestado,
    this.ejecutado,
  });

  fromJson(Map<String, dynamic> json) => new Lista2(
        detalle: json["detalle"],
        presupuestado: double.parse(json["presupuestado"].toString()),
        ejecutado:  double.parse( json["ejecutado"].toString()),
      );
}
