class RxEventModel {
  String _message;
  dynamic _data;

  RxEventModel(this._message, this._data);

  String get message => _message;
  set message(String value) {
    _message = value;
  }

  dynamic get data => _data;
  set data(dynamic value) {
    _data = value;
  }
}
