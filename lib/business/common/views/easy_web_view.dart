import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../basic/basic_instances.dart';
import '../../../basic/router/f_router.dart';
import '../../../common/extension/string_business.dart';

enum WebViewPageType {
  richText,
  url,
}

class EasyWebView extends StatefulWidget {
  const EasyWebView({
    Key? key,
    required this.type,
    this.url,
    this.richText,
    this.onWebViewCreated,
    this.onProgressChanged,
  }) : super(key: key);

  final WebViewPageType type;
  final String? url;
  final String? richText;
  final Function(InAppWebViewController)? onWebViewCreated;
  final Function(InAppWebViewController, int)? onProgressChanged;

  @override
  _EasyWebViewState createState() => _EasyWebViewState();
}

class _EasyWebViewState extends State<EasyWebView> {
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    late Widget webView;
    if (widget.type == WebViewPageType.url && widget.url != null) {
      final url = widget.url?.getIntlUrlString(context) ?? '';
      logger.i(url);

      webView = InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
        onWebViewCreated: _onWebViewCreated,
        onProgressChanged: _onProgressChanged,
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
          ),
        ),
        shouldOverrideUrlLoading: _shouldOverrideUrlLoading,
      );
    }
    if (widget.type == WebViewPageType.richText && widget.richText != null) {
      webView = Html(
        data: widget.richText,
      );
    }
    return webView;
  }

  void _onWebViewCreated(InAppWebViewController controller) {
    _webViewController = controller;
    _addNavigateHandler();

    if (widget.onWebViewCreated != null) {
      widget.onWebViewCreated?.call(controller);
    }
  }

  void _onProgressChanged(InAppWebViewController controller, int progress) {
    widget.onProgressChanged?.call(controller, progress);
  }

  Future<NavigationActionPolicy> _shouldOverrideUrlLoading(
      InAppWebViewController controller,
      NavigationAction navigationAction) async {
    final uri = navigationAction.request.url;
    final isHttp = uri?.scheme == 'http' || uri?.scheme == 'https';
    if (isHttp) {
      return NavigationActionPolicy.ALLOW;
    }

    final requestUrl = uri.toString();
    // 非http请求才执行launch操作
    if (await canLaunch(requestUrl)) {
      await launch(
        requestUrl,
        forceSafariVC: false,
      );
    }
    return NavigationActionPolicy.CANCEL;
  }

  // 网页导航到原生页面
  void _addNavigateHandler() {
    _webViewController?.addJavaScriptHandler(
      handlerName: 'navigate',
      callback: (args) {
        final url = args.first as String? ?? '';
        FRouter().pushRemotePath(url);
      },
    );
  }
}
