class AbmException implements Exception {
  final _message;
  AbmException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
