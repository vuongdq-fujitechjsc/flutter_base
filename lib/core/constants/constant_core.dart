class ConstantsCore {
  static const String BASE_URL = 'http://18.178.144.100';

  static const String API_GET_TOKEN = '/api/auth/student/token';
  static const String API_REFRESH_TOKEN = '/api/auth/token/refresh';
  static const String API_CHANGE_PASSWORD = '/api/auth/password';
  static const String API_CHANGE_PASSWORD_DEFAULT =
      '/api/auth/student/password/default';
  static const String API_GET_VERSION = '/api/student/version';
  static const String API_LOGOUT = '/api/auth/logout';

  static const String ACCESS_TOKEN = 'Authorization';

  static const String API_HEADER_KEY_1 = 'Authorization';
  static const String API_HEADER_KEY_2 = 'Accept';
  static const String API_HEADER_KEY_3 = 'Content-Type';

  static const String API_HEADER_VALUE_1 = 'Bearer ';
  static const String API_HEADER_VALUE_2 = 'application/json';
  static const String API_HEADER_VALUE_3 = 'application/json';

  //colors
  static const String COLOR_TEXT_01 = '#4F4F4F';
}
