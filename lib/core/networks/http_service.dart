import 'package:flutter/material.dart';
import 'http_interface.dart';

abstract class HttpService {
  Future<T> get<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> query,
    @required OnCompleted onCompleted,
    @required OnFailed onFailed,
  });

  Future<T> post<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
    @required OnCompleted onCompleted,
    @required OnFailed onFailed,
  });

  Future<T> put<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
    @required OnCompleted onCompleted,
    @required OnFailed onFailed,
  });

  Future<T> patch<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
    @required OnCompleted onCompleted,
    @required OnFailed onFailed,
  });

  Future<T> delete<T>(
    String subURL, {
    Map<String, String> header,
    Map<String, String> query,
    @required OnCompleted onCompleted,
    @required OnFailed onFailed,
  });

  void cancelRequest(String subURL);
  void cancelAllRequest();
}
