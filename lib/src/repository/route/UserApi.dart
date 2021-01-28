import 'package:amasventas/src/crosscutting/Const.dart';

class UserApi {
  String apiRol(String usuario) =>
      API + '/api/GetSeguridad/GetRolAsignados/$usuario';
  String apiMenu(String usuario) =>
      API + '/api/GetSeguridad/GetMenusUsuariosMobile/$usuario';
}
