import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';

class PersonalModel extends BaseEntity {
  @override
  StateEntity states;
  String tipoOperacion;
  String usuario;
  String usuarioReg;
  String nombre;
  String password;
  String web;
  String mobile;
  String fechaDesde;
  String fechaHasta;
  String codSucursal;
  String email;
  String celular;
  String paterno;
  String materno;
  String tipoDoc;
  String nroDocumento;
  String tipo;
  String motivo;
  String amadeus;
  String uid;
  String telefono;
  String jefe;
  int areadepto;
  String cargo;
  double sueldo;

  PersonalModel(
      {this.states = StateEntity.None,
      this.tipoOperacion,
      this.usuario,
      this.usuarioReg,
      this.nombre,
      this.password,
      this.web,
      this.mobile,
      this.fechaDesde,
      this.fechaHasta,
      this.codSucursal,
      this.email,
      this.celular,
      this.paterno,
      this.materno,
      this.tipoDoc,
      this.nroDocumento,
      this.tipo,
      this.motivo,
      this.amadeus,
      this.uid,
      this.telefono,
      this.jefe,
      this.areadepto,
      this.cargo,
      this.sueldo});

  Map<String, dynamic> toJson() => {
        "tipoOperacion": tipoOperacion,
        "usuario": usuario,
        "usuario_reg": usuarioReg,
        "nombre_completo": nombre,
        "password": password,
        "web": web,
        "mobile": mobile,
        "fecha_desde": fechaDesde,
        "fecha_hasta": fechaHasta,
        "cod_sucursal": codSucursal,
        "email": email,
        "celular": celular,
        "apellido_paterno": paterno,
        "apellido_materno": materno,
        "tipo_documento": tipoDoc,
        "nro_documento": nroDocumento,
        "tipo": tipo,
        "motivo": motivo,
        "codigo_amadeus": amadeus,
        "codigo_uid": uid,
        "telefono": telefono,
        "jefe_inmediato": jefe,
        "id_areadepto": areadepto,
        "cargo": cargo,
        "sueldo": sueldo,
      };
}
