import 'package:dio/dio.dart';

import '../constants/constants.dart';
import '../extensions/extensions.dart';
import '../contexts/contexts.dart';

import 'http_client.dart';
import 'package:mimamu/3.%20Utilities/log_util.dart';

class InterceptorLock extends InterceptorsWrapper {
  Dio _tokenDio = Dio();
  Dio _dio;

  InterceptorLock(this._dio) {
    _tokenDio.options = _dio.options;
  }

  @override
  Future onRequest(RequestOptions options) async {
    if (options.path != ConstantsCore.API_GET_TOKEN &&
        options.path != ConstantsCore.API_REFRESH_TOKEN) {
          //get token from local storage
      String token = '';

      if (!token.isEmptyTrim()) {
        final bearerToken = 'Bearer ' + token;
        options.headers[ConstantsCore.ACCESS_TOKEN] = bearerToken;
        LogUtil.debug('InterceptorLock: token: $bearerToken');
        return super.onRequest(options);
      }else{
        //get token
      }
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
      final bearerToken = "Bearer " + token;

      //get token from storage

      //check if token has updated
      if (bearerToken != options.headers[ConstantsCore.ACCESS_TOKEN]) {
        options.headers[ConstantsCore.ACCESS_TOKEN] = bearerToken;
        return _dio.request(options.path, options: options);
      }

      //call refresh token and re-call API
      _dio.lock();
      _dio.interceptors.responseLock.lock();
      _dio.interceptors.errorLock.lock();

      var map = Map<String, String>();
      map['token'] = token;
      return _tokenDio.post(ConstantsCore.API_REFRESH_TOKEN, data: map).then((value) {
        // Update token
        options.headers[ConstantsCore.ACCESS_TOKEN] = '';

        //UNlock
        _dio.unlock();
        _dio.interceptors.responseLock.unlock();
        _dio.interceptors.errorLock.unlock();

        //Call other request
        return _dio.request(options.path, options: options);
      }).catchError((error) {
        if (Singleton().logoutByInvalidToken != null) {
          Singleton().logoutByInvalidToken();
        }
        HttpClient.clearInstance();
      });
    }
    return super.onError(error);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }
}
