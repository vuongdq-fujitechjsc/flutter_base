import 'dart:async';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

import '../constants/constants.dart';
import '../models/model.dart';
import '../localizations/localizations.dart';
import '../utilities/utility.dart';

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
    options.headers = {
      ConstantsCore.API_HEADER_KEY_2 : ConstantsCore.API_HEADER_VALUE_2,
      ConstantsCore.API_HEADER_KEY_3 : ConstantsCore.API_HEADER_VALUE_3,
    };
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
    bool internetConnection = await checkInternetConnection();
    if (internetConnection) {
      return await _dio
          .get(subURL,
              queryParameters: query,
              cancelToken: _addCancelToken(subURL),
              options: _addOptions(header))
          .then((value) {
        var json = value.data;
        LogUtils.debug('API ==== GET $subURL');
        LogUtils.debug('API onSuccess ==== $json');
        onCompleted(json);
      }).catchError((error) {
        LogUtils.debug('API ==== GET $subURL');
        if (error is DioError) {
          LogUtils.debug(
              'API onError ==== ${error.response?.statusCode ?? 0} == ${error.response}');
        } else {
          LogUtils.debug('API onError ==== ${error.toString()}');
        }
        onFailed(ErrorResponse.withError(error: error));
      });
    } else {
      onFailed(
          ErrorResponse(errorMessage: multiLanguage.get("message_api_error")));
      return Completer().future;
    }
  }

  @override
  Future<T> post<T>(
    String subURL, {
    Map<String, String> header,
    dynamic body,
    onCompleted,
    onFailed,
  }) async {
    bool internetConnection = await checkInternetConnection();
    if (internetConnection) {
      return await _dio
          .post(subURL,
              data: body,
              cancelToken: _addCancelToken(subURL),
              options: _addOptions(header))
          .then((value) {
        var json = value.data;
        LogUtils.debug('API ==== POST $subURL');
        LogUtils.debug('API params ==== $body');
        LogUtils.debug('API onSuccess ==== $json');
        onCompleted(json);
      }).catchError((error) {
        LogUtils.debug('API ==== POST $subURL');
        LogUtils.debug('API params ==== $body');
        if (error is DioError) {
          LogUtils.debug(
              'API onError ==== ${error.response?.statusCode ?? 0} == ${error.response}');
        } else {
          LogUtils.debug('API onError ==== ${error.toString()}');
        }
        onFailed(ErrorResponse.withError(error: error));
      });
    }else{
      onFailed(
          ErrorResponse(errorMessage: multiLanguage.get("message_api_error")));
      return Completer().future;
    }
  }

  @override
  Future<T> put<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
    onCompleted,
    onFailed,
  }) async {
    bool internetConnection = await checkInternetConnection();
    if (internetConnection) {
      return await _dio
          .put(subURL,
              data: body,
              cancelToken: _addCancelToken(subURL),
              options: _addOptions(header))
          .then((value) {
        var json = value.data;
        LogUtils.debug('API ==== PUT $subURL');
        LogUtils.debug('API params ==== $body');
        LogUtils.debug('API onSuccess ==== $json');
        onCompleted(json);
      }).catchError((error) {
        LogUtils.debug('API ==== PUT $subURL');
        LogUtils.debug('API params ==== $body');
        if (error is DioError) {
          LogUtils.debug(
              'API onError ==== ${error.response?.statusCode ?? 0} == ${error.response}');
        } else {
          LogUtils.debug('API onError ==== ${error.toString()}');
        }
        onFailed(ErrorResponse.withError(error: error));
      });
    }else{
      onFailed(
          ErrorResponse(errorMessage: multiLanguage.get("message_api_error")));
      return Completer().future;
    }
  }

  @override
  Future<T> patch<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
    onCompleted,
    onFailed,
  }) async {
    bool internetConnection = await checkInternetConnection();
    if (internetConnection) {
      return await _dio
          .patch(subURL,
              data: body,
              cancelToken: _addCancelToken(subURL),
              options: _addOptions(header))
          .then((value) {
        var json = value.data;
        LogUtils.debug('API ==== PATCH $subURL');
        LogUtils.debug('API params ==== $body');
        LogUtils.debug('API onSuccess ==== $json');
        onCompleted(json);
      }).catchError((error) {
        LogUtils.debug('API ==== PATCH $subURL');
        LogUtils.debug('API params ==== $body');
        if (error is DioError) {
          LogUtils.debug(
              'API onError ==== ${error.response?.statusCode ?? 0} == ${error.response}');
        } else {
          LogUtils.debug('API onError ==== ${error.toString()}');
        }
        onFailed(ErrorResponse.withError(error: error));
      });
    }else{
      onFailed(
          ErrorResponse(errorMessage: multiLanguage.get("message_api_error")));
      return Completer().future;
    }
  }

  @override
  Future<T> delete<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> query,
    onCompleted,
    onFailed,
  }) async {
    bool internetConnection = await checkInternetConnection();
    if (internetConnection) {
      return await _dio
          .delete(subURL,
              queryParameters: query,
              cancelToken: _addCancelToken(subURL),
              options: _addOptions(header))
          .then((value) {
        var json = value.data;
        LogUtils.debug('API ==== DELETE $subURL');
        LogUtils.debug('API onSuccess ==== $json');
        onCompleted(json);
      }).catchError((error) {
        LogUtils.debug('API ==== DELETE $subURL');
        if (error is DioError) {
          LogUtils.debug(
              'API onError ==== ${error.response?.statusCode ?? 0} == ${error.response}');
        } else {
          LogUtils.debug('API onError ==== ${error.toString()}');
        }
        onFailed(ErrorResponse.withError(error: error));
      });
    } else {
      onFailed(
          ErrorResponse(errorMessage: multiLanguage.get("message_api_error")));
      return Completer().future;
    }
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