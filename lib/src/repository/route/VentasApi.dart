import 'package:amasventas/src/crosscutting/Const.dart';

class WeatherForecastApi {
  String apiconParametro(String param1) =>
      API + '/api/Abm/usuario_rol/param/{$param1}';

  String api() => 'http://amasventas.neuronatexnology.com/WeatherForecast';
}
