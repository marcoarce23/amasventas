import 'package:amasventas/src/data/entity/BaseEntity.dart';

class MultimediaList extends BaseEntity {
  int idMultimedia;
  int idOrganizacion;
  int idaCategoria;
  String titulo;
  String resumen;
  String enlace;
  String fechainicio;
  String fechafin;
  String foto;

  MultimediaList(
      {this.idMultimedia,
      this.idOrganizacion,
      this.titulo,
      this.resumen,
      this.idaCategoria,
      this.enlace,
      this.fechainicio,
      this.fechafin,
      this.foto});

  fromJson(Map<String, dynamic> json) => new MultimediaList(
        idMultimedia: json["idMultimedia"],
        idOrganizacion: json["idOrganizacion"],
        titulo: json["titulo"],
        resumen: json["resumen"],
        idaCategoria: json["idaCategoria"],
        enlace: json["enlace"],
        fechainicio: json["fechainicio"],
        fechafin: json["fechafin"],
        foto: json["foto"],
      );
}
