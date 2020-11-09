import 'package:dio/dio.dart' hide Headers;
import 'package:json_annotation/json_annotation.dart';

import '../localizations/localizations.dart';

@JsonSerializable()
class ErrorModel implements Exception {
  String errorCode;
  String errorMessage;

  ErrorModel(
    this.errorCode,
    this.errorMessage,
  );

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      json['error_code'] as String,
      json['error_messge'] as String,
    );
  }

  @override
  String toString() {
    return '$errorCode : $errorMessage';
  }
}

@JsonSerializable()
class ErrorResponse {
  List<ErrorModel> errors;
  String errorMessage = '';
  int errorCode = 0;

  ErrorResponse({this.errors, this.errorMessage});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      errors: (json['errors'] as List)
          ?.map((error) => error == null
              ? null
              : ErrorModel.fromJson(error as Map<String, dynamic>))
          ?.toList(),
    );
  }

  ErrorResponse.withError({DioError error}) {
    _handleError(error);
  }

  _handleError(DioError error) {
    // switch (error.type) {
    //   case DioErrorType.CANCEL:
    //     errorMessage = "HTTP Request was cancelled !";
    //     break;
    //   case DioErrorType.CONNECT_TIMEOUT:
    //     errorMessage = "HTTP Request was connection timeout !";
    //     break;
    //   case DioErrorType.SEND_TIMEOUT:
    //     errorMessage = "HTTP Request was send timeout !";
    //     break;
    //   case DioErrorType.RECEIVE_TIMEOUT:
    //     errorMessage = "HTTP Request was receive timeout !";
    //     break;
    //   case DioErrorType.DEFAULT:
    //     errorMessage = "HTTP Request was failed !";
    //     break;
    //   case DioErrorType.RESPONSE:
    //     errorMessage =
    //         "HTTP Request was responsed with status code: ${error.response.statusCode}";
    //     break;
    // }

    //Map errror list
    if (error?.response?.data != null) {
      if (error?.response?.data['errors'] != null) {
        if (error?.response?.data['errors'] is List) {
          errors = (error?.response?.data['errors'] as List)
              ?.map((error) => error == null
                  ? null
                  : ErrorModel.fromJson(error as Map<String, dynamic>))
              ?.toList();
        }
      }
    }

    //Get error message
    errorCode = error?.response?.statusCode;
    if (errorCode == null || errorCode > 500) {
      errorMessage = multiLanguage.get('MSG001');
    } else {
      errorMessage = _getErrorMessage();
    }
  }

  String _getErrorMessage() {
    if (errors != null && errors.length > 0) {
      return errors.map((error) => error.errorMessage ?? "").join('\n');
    } else {
      return multiLanguage.get('message_api_error');
    }
  }
}
