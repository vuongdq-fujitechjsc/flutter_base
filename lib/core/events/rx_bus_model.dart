class RxEventModel {
  String _message;
  dynamic _data;
  String _origin;

  RxEventModel(this._message, this._data, this._origin);

  String get message => _message;
  set message(String value) {
    if(value == null){
      throw new ArgumentError();
    }
    _message = value;
  }

  dynamic get data => _data;
  set data(dynamic value) {
    if(value == null){
      throw new ArgumentError();
    }
    _data = value;
  }

  String get origin => _origin;
  set origin(String value) {
    if(value == null){
      throw new ArgumentError();
    }
    _origin = value;
  }
}
