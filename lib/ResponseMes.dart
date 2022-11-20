
class ResponseMes {

  late String _message;
  late bool _success;

  ResponseMes(this._message, this._success);

  bool get success => _success;

  set success(bool value) {
    _success = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }
}