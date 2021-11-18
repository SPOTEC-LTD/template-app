import 'package:flutter/foundation.dart';

// 开发环境网页链接
const devBaseWebURL = '';
// 测试环境网页链接
const testBaseWebURL = '';
// 生产环境网页链接
const productBaseWebURL = '';

// 开发环境API链接
const devBaseAPIURL = '';
// 测试环境API链接
const testBaseAPIURL = '';
// 生产环境API链接
const productBaseAPIURL = '';

/// 网页base
const baseWebURL = kDebugMode ? devBaseWebURL : testBaseWebURL;

/// 接口base
const baseAPIURL = kDebugMode ? devBaseAPIURL : testBaseAPIURL;

/// 远程路由的url有该前缀，则可以尝试打开本地页面
const innerUrl = 'http://app.template.com';
