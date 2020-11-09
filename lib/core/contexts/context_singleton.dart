class Singleton {
  static final Singleton _singleton = Singleton._internal();

  Function logoutByInvalidToken;

  factory Singleton() {
    return _singleton;
  }

  void logout() {}

  Singleton._internal();
}
