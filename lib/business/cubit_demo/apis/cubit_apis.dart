import '../../../common/http/http_service.dart';
import '../models/post_entity.dart';

class CubitApis {
  static const _getPostsUrl = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<PostEntity>> getPosts(int start) async {
    return HttpService.anyRequest<List<dynamic>>(
      'get',
      _getPostsUrl,
      contentType: HttpContentType.form,
      params: {
        '_start': start,
        '_limit': 5,
      },
    ).then((list) {
      // // 模拟无数据
      // return [];

      // 模拟没有更多
      if (start > 20) {
        return [];
      }

      final posts = list.map((e) => PostEntity().fromJson(e)).toList();
      return posts;
    });
  }
}
