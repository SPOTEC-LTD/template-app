import '../../basic/router/f_router.dart';

extension FRouterCommonExtension on FRouter {
  /// 参数为空的时候，显示的异常页面
  String get routeParamNullPage => '/routeParamNullPage';

  /// 通用内部网页
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
      'typeIndex': typeIndex,
      'url': url,
      'richText': richText,
      'title': title,
      'showAppBar': showAppBar,
      'showShareButton': showShareButton,
    };
  }
}
