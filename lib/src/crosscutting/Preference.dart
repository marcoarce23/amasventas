import 'package:shared_preferences/shared_preferences.dart';
import 'package:amasventas/src/crosscutting/Const.dart';

class Preferense {
  static final Preferense _instancia = new Preferense._internal();

  factory Preferense() {
    return _instancia;
  }

  Preferense._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }
  // GET y SET del Genero

  get imei {
    return _prefs.getString('imei') ?? '-1';
  }

  set imei(String value) {
    _prefs.setString('imei', value);
  }

  // GET y SET del _colorSecundario
  get document {
    return _prefs.getString('document') ?? '-1';
  }

  set document(String value) {
    _prefs.setString('document', value);
  }

  // GET y SET del correo
  get email {
    return _prefs.getString('email') ?? 'marcoarce23@gmail.com';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  // GET y SET del nombreUsuario
  get nameUser {
    return _prefs.getString('nameUser') ?? '-1';
  }

  set nameUser(String value) {
    _prefs.setString('nameUser', value);
  }

  get nameInstitution {
    return _prefs.getString('nameInstitution') ?? '-1';
  }

  set nameInstitution(String value) {
    _prefs.setString('nameInstitution', value);
  }

  get idLogin {
    return _prefs.getString('idLogin') ?? '0';
  }

  set idLogin(String value) {
    _prefs.setString('idLogin', value);
  }

  get token {
    return _prefs.getString('token') ?? '-1';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get idInstitution {
    return _prefs.getString('idInstitution') ?? '2';
  }

  set idInstitution(String value) {
    _prefs.setString('idInstitution', value);
  }

  get userId {
    return _prefs.getString('userId') ?? '1';
  }

  set userId(String value) {
    _prefs.setString('userId', value);
  }

  get idPersonal {
    return _prefs.getString('idPersonal') ?? '3';
  }

  set idPersonal(String value) {
    _prefs.setString('idPersonal', value);
  }

  get idDepartament {
    return _prefs.getInt('idDepartament') ?? 60;
  }

  set idDepartament(int value) {
    _prefs.setInt('idDepartament', value);
  }

  get departament {
    return _prefs.getString('departament') ?? 'La Paz';
  }

  set departament(String value) {
    _prefs.setString('departament', value);
  }

  // GET y SET de la última página
  get lastPage {
    return _prefs.getString('lastPage') ?? 'login';
  }

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }

  get avatarImage {
    return _prefs.getString('avatarImage') ?? IMAGE_LOGO;
  }

  set avatarImage(String value) {
    _prefs.setString('avatarImage', value);
  }
}
