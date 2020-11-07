import 'package:dio/dio.dart';
import 'package:mimamu/1.%20Commons/Constants/constant.dart';
import 'package:mimamu/3.%20Utilities/log_util.dart';
import 'package:mimamu/1.%20Commons/Extenstions/string_ext.dart';

class InterceptorLock extends InterceptorsWrapper {
  Dio _tokenDio = Dio();
  Dio _dio;

  InterceptorLock(this._dio) {
    _tokenDio.options = _dio.options;
  }

  @override
  Future onRequest(RequestOptions options) {
    LogUtil.debug(
        'Interceptor - Send request with: \n path: ${options.path}, \n baseURL: ${options.baseUrl}');

    String token = '';

    //get token from storage
    LogUtil.info('Interceptor - Token: $token');

    if (!token.isEmptyTrim()) {
      options.headers[Constant.ACCESS_TOKEN] = token;
      return super.onRequest(options);
    } else {
      //get token
    }
    return super.onRequest(options);
  }

  @override
  Future onError(DioError error) {
    var httpCode = error.response.statusCode;

    if (httpCode == 401) {
      //refresh token
      var options = error.response.request;
      String token = '';
      //get token from storage
      //check if token has updated
      if (token != options.headers[Constant.ACCESS_TOKEN]) {
        options.headers[Constant.ACCESS_TOKEN] = token;
        return _dio.request(options.path, options: options);
      }

      //call refresh token and re-call API
      _dio.lock();
      _dio.interceptors.responseLock.lock();
      _dio.interceptors.errorLock.lock();

      return _tokenDio.get("").then((value) {
        //update token to storage and header
        options.headers[Constant.ACCESS_TOKEN] = '';
      }).whenComplete(() {
        _dio.unlock();
        _dio.interceptors.responseLock.unlock();
        _dio.interceptors.errorLock.unlock();
      }).then((value) {
        //re-call API
        return _dio.request(options.path, options: options);
      });
    }
    return super.onError(error);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }
}
