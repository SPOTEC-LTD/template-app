import 'dart:io';

import 'package:dio/dio.dart';

class HttpErrorHandler {
  // static Future handlerError(DioError error) {}

  static String getMessageFromHttpError(DioError error) {
    // e.error为SocketException时，e.message过长，应测试要求特别处理
    if (error.error is SocketException) {
      return error.error.message;
    }
    if (error.response == null) {
      // return S.of(Global.context).httpError;
      return '';
    }
    var statusCode = error.response?.statusCode;
    if (statusCode != null && (400 <= statusCode || statusCode <= 500)) {
      // return S.of(Global.context).httpError;
      return '';
    }
    return error.message;
  }
}
