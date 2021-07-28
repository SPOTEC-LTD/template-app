import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:template/extensions/string_extension.dart';
import 'package:template/managers/color_manager.dart';
import 'package:template/managers/icon_manager.dart';
import 'package:template/module/common/views/easy_web_view.dart';
import 'package:template/utils/screen_util.dart';
import 'package:template/widgets/base/base_app_bar.dart';

export 'package:template/module/common/views/easy_web_view.dart';

class WebViewPage extends StatefulWidget {
  final WebViewPageType type;
  final String? url;
  final String? richText;
  final String? title;
  final bool showAppBar;
  final bool showShareButton;
  final Function(InAppWebViewController)? onWebViewCreated;

  const WebViewPage({
    Key? key,
    required this.type,
    this.url,
    this.richText,
    this.title,
    this.showAppBar = true,
    this.showShareButton = false,
    this.onWebViewCreated,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  late String _title;

  InAppWebViewController? _webViewController;
  double _progress = 0;

  String get _localUrl => widget.url?.intlUrlString ?? '';

  @override
  void initState() {
    super.initState();
    _title = widget.title ?? 'S.of(Global.context).webDefaultTitle';
  }

  void _share(String url) {
    // Share.text(S.of(context).webShareLink, url, 'text/plain');
  }

  void _onWebViewCreated(InAppWebViewController controller) {
    _webViewController = controller;
    if (widget.onWebViewCreated != null) {
      widget.onWebViewCreated?.call(controller);
    }
  }

  void _onProgressChanged(InAppWebViewController controller, int progress) {
    setState(() {
      _progress = progress / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    var url = widget.url;
    if (widget.url != null && widget.showAppBar == false) {
      url = widget.url! + '&topPadding=${ScreenUtil.topPadding}';
    }

    return Scaffold(
      appBar: widget.showAppBar ? _buildAppBar() : null,
      body: EasyWebView(
        type: widget.type,
        url: url,
        richText: widget.richText,
        onWebViewCreated: _onWebViewCreated,
        onProgressChanged: _onProgressChanged,
      ),
    );
  }

  Widget _buildShareButton() {
    return Offstage(
      offstage: !widget.showShareButton,
      // child: IconButton(
      //   color: ColorManager.backgroundWhite,
      //   icon: Image.asset(ImageManager.share_icon),
      //   onPressed: () {
      //     _share(_localUrl);
      //   },
      // ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    var appBar = BaseAppBar(
      backgroundColor: ColorManager.lineD8D8D8,
      brightness: Brightness.dark,
      titleText: _title,
      isCenter: true,
      leading: GestureDetector(
        child: Image.asset(IconManager.nav_icon_back_white),
        onTap: _popIfNeeded,
      ),
      actions: [
        _buildShareButton(),
      ],
    );

    return PreferredSize(
      preferredSize: Size.fromHeight(ScreenUtil.appBarHeight),
      child: Stack(
        children: [
          appBar,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Offstage(
              offstage: _progress >= 1,
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 2,
                valueColor: AlwaysStoppedAnimation(ColorManager.lineD8D8D8),
                backgroundColor: ColorManager.backgroundWhite,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 网页如果不可以回退，则pop当前页面
  void _popIfNeeded() {
    if (widget.type == WebViewPageType.url) {
      _webViewController?.canGoBack().then((value) {
        if (value) {
          _webViewController?.goBack();
        } else {
          return Navigator.pop(context);
        }
      });
    } else {
      return Navigator.pop(context);
    }
  }
}
