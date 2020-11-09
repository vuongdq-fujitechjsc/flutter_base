import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

import '../constants/constants.dart';
import '../models/models.dart';

import 'http_service.dart';
import 'http_service_rx.dart';
import 'interceptor_lock.dart';

class HttpClient implements HttpService, RxHttpService {
  static HttpClient _instance;

  static HttpClient getInstance({baseURL, timeOut = 30000, debug = false}) {
    if (_instance == null) {
      _instance = HttpClient(baseURL, timeOut, debug);
    }
    return _instance;
  }

  static clearInstance() {
    _instance = null;
  }

  Dio _dio;
  InterceptorLock _interceptor;
  Map<String, CancelToken> _cancelTokenMap;

  HttpClient(String baseURL, int timeOut, bool isDebug) {
    _dio = Dio();

    BaseOptions options = BaseOptions();
    options.baseUrl = ConstantsCore.BASE_URL;
    options.connectTimeout = timeOut;
    options.sendTimeout = timeOut;
    options.receiveTimeout = timeOut;
    _dio.options = options;

    _interceptor = InterceptorLock(_dio);
    _dio.interceptors.add(_interceptor);
    if (isDebug) {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }

    _cancelTokenMap = Map<String, CancelToken>();
  }

  Dio get dio => _dio;

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  Future<T> get<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> query,
    onCompleted,
    onFailed,
  }) async {
    return await _dio
        .get(subURL,
            queryParameters: query,
            cancelToken: _addCancelToken(subURL),
            options: _addOptions(header))
        .then((value) {
      var json = value.data;
      onCompleted(json);
    }).catchError((error) {
      onFailed(HttpError.withError(error: error));
    });
  }

  @override
  Future<T> post<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
    onCompleted,
    onFailed,
  }) async {
    return await _dio
        .post(subURL,
            data: body,
            cancelToken: _addCancelToken(subURL),
            options: _addOptions(header))
        .then((value) {
      var json = value.data;
      onCompleted(json);
    }).catchError((error) {
      onFailed(HttpError.withError(error: error));
    });
  }

  @override
  Future<T> put<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
    onCompleted,
    onFailed,
  }) async {
    return await _dio
        .put(subURL,
            data: body,
            cancelToken: _addCancelToken(subURL),
            options: _addOptions(header))
        .then((value) {
      var json = value.data;
      onCompleted(json);
    }).catchError((error) {
      onFailed(HttpError.withError(error: error));
    });
  }

  @override
  Future<T> patch<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
    onCompleted,
    onFailed,
  }) async {
    return await _dio
        .patch(subURL,
            data: body,
            cancelToken: _addCancelToken(subURL),
            options: _addOptions(header))
        .then((value) {
      var json = value.data;
      onCompleted(json);
    }).catchError((error) {
      onFailed(HttpError.withError(error: error));
    });
  }

  @override
  Future<T> delete<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> query,
    onCompleted,
    onFailed,
  }) async {
    return await _dio
        .delete(subURL,
            queryParameters: query,
            cancelToken: _addCancelToken(subURL),
            options: _addOptions(header))
        .then((value) {
      var json = value.data;
      onCompleted(json);
    }).catchError((error) {
      onFailed(HttpError.withError(error: error));
    });
  }

  @override
  Stream rxGet(
    String subURL, {
    Map<String, String> header,
    Map<String, String> query,
  }) {
    return Stream.fromFuture(_dio.get(
      subURL,
      queryParameters: query,
      cancelToken: _addCancelToken(subURL),
      options: _addOptions(header),
    ));
  }

  @override
  Stream rxPost(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
  }) {
    return Stream.fromFuture(_dio.post(
      subURL,
      data: body,
      cancelToken: _addCancelToken(subURL),
      options: _addOptions(header),
    ));
  }

  @override
  Stream rxPut(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
  }) {
    return Stream.fromFuture(_dio.put(
      subURL,
      data: body,
      cancelToken: _addCancelToken(subURL),
      options: _addOptions(header),
    ));
  }

  @override
  Stream rxPatch(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
  }) {
    return Stream.fromFuture(_dio.patch(
      subURL,
      data: body,
      cancelToken: _addCancelToken(subURL),
      options: _addOptions(header),
    ));
  }

  @override
  Stream rxDelete(
    String subURL, {
    Map<String, String> header,
    Map<String, String> query,
  }) {
    return Stream.fromFuture(_dio.delete(
      subURL,
      queryParameters: query,
      cancelToken: _addCancelToken(subURL),
      options: _addOptions(header),
    ));
  }

  CancelToken _addCancelToken(String subKey) {
    CancelToken _cancelToken = CancelToken();
    _cancelTokenMap[subKey] = _cancelToken;

    return _cancelToken;
  }

  Options _addOptions(Map<String, String> header) {
    if (header == null || header.length == 0) {
      return null;
    }
    Options _options = Options();
    _options.headers = header;

    return _options;
  }

  @override
  void cancelRequest(String subURL) {
    var _cancelToken = _cancelTokenMap[subURL];
    _cancelToken?.cancel('Cancelled !');
  }

  @override
  void cancelAllRequest() {
    _cancelTokenMap.forEach((key, value) {
      value.cancel('All Cancelled !');
    });
    _cancelTokenMap.clear();
  }
}
