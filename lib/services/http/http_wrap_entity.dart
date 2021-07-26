import 'package:template/generated/json/base/json_convert_content.dart';

import 'http_status_code.dart';

class HttpWrapEntity<T> {
  late HttpWrapHeader header;
  T? body;

  bool get isRequestSuccess {
    return header.code == HttpServiceCode.success && body != null;
  }

  HttpWrapEntity.fromJSON(Map<String, dynamic> jsonString) {
    header = HttpWrapHeader.fromJSON(jsonString['header']);
    if (jsonString['body'] != null) {
      body = _generateOBJ(jsonString['body']);
    }
  }

  T _generateOBJ(Object jsonString) {
    if (T.toString() == 'String') {
      return jsonString.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return jsonString as T;
    } else {
      // List类型数据由fromJsonAsT判断处理
      return JsonConvert.fromJsonAsT<T>(jsonString);
    }
  }
}

class HttpWrapHeader {
  late String code;
  late String message;
  late Map<String, String> messageDetails;

  HttpWrapHeader.fromJSON(Map<String, dynamic> jsonString) {
    code = jsonString['code'] ?? '';
    message = jsonString['message'] ?? '';
    if (jsonString['messageDetails'] == null) {
      messageDetails = {};
    } else {
      messageDetails = Map<String, String>.from(jsonString['messageDetails']);
    }
  }
}
