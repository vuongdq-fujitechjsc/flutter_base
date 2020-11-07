import 'package:dio/dio.dart' hide Headers;
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class HttpError implements Exception {
  String errorCode;
  String errorMessage;

  HttpError(this.errorCode, this.errorMessage);

  factory HttpError.fromJson(Map<String, dynamic> json) {
    return HttpError(
      json['error_code'] as String,
      json['error_messge'] as String,
    );
  }

  HttpError.withError({DioError error}) {
    _handleError(error);
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorMessage = "HTTP Request was cancelled !";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorMessage = "HTTP Request was connection timeout !";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorMessage = "HTTP Request was send timeout !";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorMessage = "HTTP Request was receive timeout !";
        break;
      case DioErrorType.DEFAULT:
        errorMessage = "HTTP Request was failed !";
        break;
      case DioErrorType.RESPONSE:
        errorMessage =
            "HTTP Request was responsed with status code: ${error.response.statusCode}";
        break;
    }

    var body = error.response.extra;
    var errorBody = body['error'];
    try {
      errorCode = errorBody['error_code'];
      errorMessage = errorBody['error_message'];
    } catch (error) {
      errorCode = '-1';
      errorMessage = '${error.toString()}';
    }
  }
}
