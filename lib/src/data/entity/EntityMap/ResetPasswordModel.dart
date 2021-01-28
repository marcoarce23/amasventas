import 'package:amasventas/src/data/entity/BaseEntity.dart';
import 'package:amasventas/src/data/entity/StateEntity.dart';

class ResetPasswordModel extends BaseEntity {
  @override
  StateEntity states;
  String coidgoUid;
  String usuario;

  ResetPasswordModel(
      {this.states = StateEntity.None,
      this.coidgoUid,
      this.usuario});

  Map<String, dynamic> toJson() => {
        "coidgoUid": coidgoUid,
        "usuario": usuario
      };
}
