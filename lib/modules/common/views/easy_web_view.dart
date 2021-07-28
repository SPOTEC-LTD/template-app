import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:template/extensions/string_extension.dart';
import 'package:template/routes/f_router.dart';
import 'package:url_launcher/url_launcher.dart';

enum WebViewPageType {
  richText,
  url,
}

class EasyWebView extends StatefulWidget {
  final WebViewPageType type;
  final String? url;
  final String? richText;
  final Function(InAppWebViewController)? onWebViewCreated;
  final Function(InAppWebViewController, int)? onProgressChanged;

  EasyWebView({
    Key? key,
    required this.type,
    this.url,
    this.richText,
    this.onWebViewCreated,
    this.onProgressChanged,
  }) : super(key: key);

  @override
  _EasyWebViewState createState() => _EasyWebViewState();
}

class _EasyWebViewState extends State<EasyWebView> {
  InAppWebViewController? _webViewController;

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
    var uri = navigationAction.request.url;
    var isHttp = uri?.scheme == 'http' || uri?.scheme == 'https';
    if (isHttp) {
      return NavigationActionPolicy.ALLOW;
    }

    var requestUrl = uri.toString();
    // 非http请求才执行launch操作
    if (await canLaunch(requestUrl)) {
      await launch(
        requestUrl,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
    return NavigationActionPolicy.CANCEL;
  }

  // 网页导航到原生页面
  void _addNavigateHandler() {
    _webViewController?.addJavaScriptHandler(
      handlerName: 'navigate',
      callback: (args) {
        FRouter().navigateRemote(context, args.first);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    late Widget webView;
    if (widget.type == WebViewPageType.url && widget.url != null) {
      var url = widget.url?.intlUrlString ?? '';
      print(url);

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
}
