import '../../../generated/json/base/json_convert_content.dart';

class PostEntity with JsonConvert<PostEntity> {
  int userId = 0;
  int id = 0;
  String title = '';
  String body = '';
}
