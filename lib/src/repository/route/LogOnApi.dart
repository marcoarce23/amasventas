import 'package:amasventas/src/crosscutting/Const.dart';

class LogOnApi {
  String apiconParametro(String param1) =>
      API + '/api/Abm/usuario_rol/param/{$param1}';

  String api() => API + '/api/Abm/setValidaCredenciales';
  String apiAD() => API + '/api/GetSeguridad/GetAccesoAD';
  String apiPassword() => API + '/api/Abm/set_cambio_password';
  String apiReset() => API + '/api/Abm/setresetpassword';
}
