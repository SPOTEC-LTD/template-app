import 'dart:async';
import 'package:dio/dio.dart';

import 'http_error_handler.dart';
import 'http_wrap_entity.dart';

enum HttpContentType {
  json,
  form,
}

class HttpError {
  final String code;
  final String message;
  final bool isCancel;

  HttpError(
    this.code,
    this.message,
    this.isCancel,
  );
}

class HttpService {
  static final baseAPIURL = '';
  static final Dio _dio = () {
    var dio = Dio();
    dio.options.baseUrl = baseAPIURL;
    dio.options.connectTimeout = 30000;
    dio.options.sendTimeout = 30000;
    dio.options.receiveTimeout = 30000;
    dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: false));
    return dio;
  }();

  static Future<T> get<T>(String path,
      {Map<String, Object?>? params, HttpContentType? contentType}) async {
    return _request('get', path, params: params, contentType: contentType);
  }

  static Future<T> post<T>(String path,
      {Map<String, Object?>? params, HttpContentType? contentType}) async {
    return _request('post', path, params: params, contentType: contentType);
  }

  static Future<T> put<T>(String path,
      {Map<String, Object?>? params, HttpContentType? contentType}) async {
    return _request('put', path, params: params, contentType: contentType);
  }

  static Future<T> delete<T>(String path,
      {Map<String, Object?>? params, HttpContentType? contentType}) async {
    return _request('delete', path, params: params, contentType: contentType);
  }

  static Future<T> _request<T>(String method, String path,
      {Map<String, Object?>? params, HttpContentType? contentType}) async {
    final type = contentType == HttpContentType.form
        ? 'application/x-www-form-urlencoded'
        : 'application/json; charset=utf-8';
    final isGet = method == 'get';
    final headers = <String, Object?>{
      'Authorization': '',
      'platformType': 'APP',
      'lang': '',
    };
    params?.removeWhere((key, value) => value == null);

    try {
      final response = await _dio.request(
        path,
        data: isGet ? null : params,
        queryParameters: isGet ? params : null,
        options: Options(
          method: method,
          contentType: type,
          headers: headers,
        ),
      );
      final wrapper = HttpWrapEntity<T>.fromJSON(response.data);
      if (wrapper.isRequestSuccess) {
        return wrapper.body!;
      } else {
        var message = wrapper.header.message;
        if (wrapper.header.messageDetails.isNotEmpty == true) {
          var values = wrapper.header.messageDetails.values;
          message = values.reduce((value, element) => value + '\n' + element);
        }
        return Future.error(HttpError(wrapper.header.code, message, false));
      }
    } on DioError catch (e) {
      var isCancel = e.type == DioErrorType.cancel;
      var message = HttpErrorHandler.getMessageFromHttpError(e);
      return Future.error(HttpError(
          e.response?.statusCode?.toString() ?? '', message, isCancel));
    }
  }

  /// 上传单个文件
  static Future<T> uploadSingleFile<T>(String filePath, String filename) async {
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: filename),
    });
    try {
      var response = await _dio.post('/oss/file/upload', data: formData);
      var wrapper = HttpWrapEntity<T>.fromJSON(response.data);
      if (wrapper.isRequestSuccess) {
        return wrapper.body!;
      } else {
        return Future.error(
            HttpError(wrapper.header.code, wrapper.header.message, false));
      }
    } on DioError catch (e) {
      var isCancel = e.type == DioErrorType.cancel;
      throw HttpError(
          e.response?.statusCode.toString() ?? '', e.message, isCancel);
    }
  }

  /// 临时性的请求走该方法
  static Future<T> anyRequest<T>(
    String method,
    String path, {
    Map<String, Object?>? params,
    Map<String, Object>? headers,
    HttpContentType? contentType,
  }) async {
    final type = contentType == HttpContentType.form
        ? 'application/x-www-form-urlencoded'
        : 'application/json; charset=utf-8';
    final isGet = method == 'get';
    params?.removeWhere((key, value) => value == null);

    try {
      final response = await _dio.request(
        path,
        data: isGet ? null : params,
        queryParameters: isGet ? params : null,
        options: Options(
          method: method,
          contentType: type,
          headers: headers,
        ),
      );
      return response.data as T;
    } on DioError catch (e) {
      var isCancel = e.type == DioErrorType.cancel;
      return Future.error(HttpError(
          e.response?.statusCode?.toString() ?? '', e.message, isCancel));
    }
  }
}
