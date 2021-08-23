import '../../basic/router/f_router.dart';

extension FRouterCommonExtension on FRouter {
  String get webViewPage => '/webView/webViewPage';

  /// 返回网页参数 map
  ///
  /// [typeIndex] 网页加载数据的类型 0-富文本 1-url
  Map<String, Object?> webViewPageParams({
    required int typeIndex,
    String? url,
    String? richText,
    String? title,
    bool showAppBar = true,
    bool showShareButton = true,
  }) {
    return {
      'typeIndex': typeIndex.toString(),
      'url': url,
      'richText': richText,
      'title': title,
      'showAppBar': showAppBar,
      'showShareButton': showShareButton,
    };
  }
}
