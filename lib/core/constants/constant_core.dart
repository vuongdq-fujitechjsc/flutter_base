class ConstantsCore {
  static const String BASE_URL = 'https://dev.mimamu.co.jp';

  static const String API_GET_TOKEN = '/api/auth/student/token';
  static const String API_REFRESH_TOKEN = '/api/auth/token/refresh';
  static const String API_CHANGE_PASSWORD = '/api/auth/password';
  static const String API_CHANGE_PASSWORD_DEFAULT =
      '/api/auth/student/password/default';
  static const String API_GET_VERSION = '/api/student/version';
  static const String API_LOGOUT = '/api/auth/logout';

  static const String WEB_QR_CODE = BASE_URL + '/admin/attendance/code/student/';
  static const String WEB_IN_OUT_MANEGEMENT = BASE_URL + '/admin/attendance/month/student/';
  static const String WEB_EVENT = BASE_URL + '/admin/event/app/event-calendar/';
  static const String WEB_DISCUSSION = BASE_URL + '/admin/intv-app/list/';
  static const String WEB_NOTIFICATION = BASE_URL + '/admin/jouhoubox/app/jouhou-list/';
  static const String WEB_COMMUNICATION = BASE_URL + '/admin/communication/app/class';

  static const String ACCESS_TOKEN = 'Authorization';

  static const String API_HEADER_KEY_1 = 'Authorization';
  static const String API_HEADER_KEY_2 = 'Accept';
  static const String API_HEADER_KEY_3 = 'Content-Type';

  static const String API_HEADER_VALUE_1 = 'Bearer ';
  static const String API_HEADER_VALUE_2 = 'application/json';
  static const String API_HEADER_VALUE_3 = 'application/json';

  static const String STORAGE_ACCOUNT_ACTIVE = 'account_active';
  static const String STORAGE_IS_LOGIN = 'is_login';
}

enum EmitEventName {
  ToogleMenu,
}

enum LoginViewMode {
  Login,
  AddAccount,
}
