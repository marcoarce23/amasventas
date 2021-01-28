import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';

class NotificacionModel extends BaseEntity {
  @override
  StateEntity states;
  int idNotificacion;
  int idOrganizacion;
  String titulo;
  String detalle;
  String foto;
  String usuarioAuditoria;

  NotificacionModel(
      {this.states = StateEntity.None,
      this.idNotificacion = 0,
      this.idOrganizacion,
      this.titulo,
      this.detalle,
      this.foto,
      this.usuarioAuditoria,
   });

  Map<String, dynamic> toJson() => {
        "idNotificacion": idNotificacion,
        "idOrganizacion": idOrganizacion,
        "titulo": titulo,
        "detalle": detalle,
        "foto": foto,
        "usuarioAuditoria": usuarioAuditoria,
   
      };
}
