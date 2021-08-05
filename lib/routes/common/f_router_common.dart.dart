import 'package:template/basic/router/f_router.dart';

extension FRouterCommonExtension on FRouter {
  String get webViewPage => '/webView/webViewPage';

  /// 0-富文本 1-url
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
