class AssetUtils {
  static AssetUtils _instance;
  static AssetUtils instance({path = 'assets/images/'}){
    if(_instance == null){
      _instance = AssetUtils(path);
    }
    return _instance;
  }

  var _path;
  AssetUtils(this._path);

  String getImageUrl(String name) {
    return '$_path$name';
  }
}
