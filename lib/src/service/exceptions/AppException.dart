class AppException implements Exception {
  final _message;
  AppException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
