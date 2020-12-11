import 'package:dio/dio.dart';

import '../constants/constants.dart';
import '../extensions/extensions.dart';
import '../contexts/contexts.dart';
import '../utilities/utility.dart';
import '../storages/storage.dart';

import '../../src/login/model/login_model.dart';

import 'http_client.dart';

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
      final account = await SharedPreferencesManager.get(
          ConstantsCore.STORAGE_ACCOUNT_ACTIVE, "");
      LoginData currentAccount = await DBProvider.db.getUser(account);

      if (!currentAccount.access_token.isEmptyTrim()) {
        final bearerToken =
            ConstantsCore.API_HEADER_VALUE_1 + currentAccount.access_token;
        options.headers[ConstantsCore.ACCESS_TOKEN] = bearerToken;
        LogUtils.debug('InterceptorLock: token: $bearerToken');
        return super.onRequest(options);
      }

      // String token = '';

      // if (!token.isEmptyTrim()) {
      //   final bearerToken = 'Bearer ' + token;
      //   options.headers[ConstantsCore.ACCESS_TOKEN] = bearerToken;
      //   LogUtils.debug('InterceptorLock: token: $bearerToken');
      //   return super.onRequest(options);
      // } else {
      //   //get token
      // }
    }
    return super.onRequest(options);
  }

  @override
  Future onError(DioError error) async {
    var httpCode = error.response.statusCode;

    if (httpCode == 401 &&
        !(error.request.path == ConstantsCore.API_GET_TOKEN ||
            error.request.path == ConstantsCore.API_REFRESH_TOKEN)) {
      //REFRESH TOKEN
      //get refresh token from storage
      var options = error.response.request;
      String activeAccount = await SharedPreferencesManager.get(
          ConstantsCore.STORAGE_ACCOUNT_ACTIVE, "");
      LoginData account = await DBProvider.db.getUser(activeAccount);
      final bearerToken = account.refresh_token;

      // //check if token has updated
      // if (bearerToken != options.headers[ConstantsCore.ACCESS_TOKEN]) {
      //   options.headers[ConstantsCore.ACCESS_TOKEN] = bearerToken;
      //   return _dio.request(options.path, options: options);
      // }

      //call refresh token and re-call API
      _dio.lock();
      _dio.interceptors.responseLock.lock();
      _dio.interceptors.errorLock.lock();

      var map = Map<String, String>();
      map['refresh_token'] = bearerToken;
      return _tokenDio
          .post(ConstantsCore.API_REFRESH_TOKEN, data: map)
          .then((value) {
        // Update token
        options.headers[ConstantsCore.ACCESS_TOKEN] =
            ConstantsCore.API_HEADER_KEY_1 + (value.data as LoginData).access_token;

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
