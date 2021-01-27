import 'package:amasventas/src/data/entity/BaseEntity.dart';

class NotificacionList extends BaseEntity {
  int idNotificacion;
  String titulo;
  String detalle;
  String foto;
  String usuariocreacion;
  String fechacreacion;
  int idOrganizacion;

  NotificacionList(
      {this.idNotificacion,
      this.titulo,
      this.detalle,
      this.usuariocreacion,
      this.fechacreacion,
      this.idOrganizacion});

  fromJson(Map<String, dynamic> json) => new NotificacionList(
        idNotificacion: json["idNotificacion"],
        titulo: json["titulo"],
        detalle: json["detalle"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        idOrganizacion: json["idOrganizacion"],
      );
}
