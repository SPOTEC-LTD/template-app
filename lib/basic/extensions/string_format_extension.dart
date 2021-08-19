// Author: Dean.Liu
// DateTime: 2021/08/12 18:45

import 'num_format_extension.dart';

/// 格式化字符串
extension StringFormateExtension on String? {
  /// 根据规定小数点格式化为金融数值
  ///
  /// [maxDigits] 最大小数位数
  /// [minDigits] 最小小数位数
  /// [needNumSign] 是否显示 +、- 号
  /// [placeholder] number 为 null 的返回值，占位符
  String? formatFinancialString(
    int maxDigits, {
    int minDigits = 0,
    bool needNumSign = false,
    String placeholder = '--',
  }) {
    final result = double.tryParse(this ?? '');
    return result.formatFinancialNumber(
      maxDigits,
      minDigits: minDigits,
      needNumSign: needNumSign,
      placeholder: placeholder,
    );
  }

  /// 根据规定小数点格式化为百分数
  ///
  /// [maxDigits] 最大小数位数
  /// [minDigits] 最小小数位数
  /// [needNumSign] 是否显示 +、- 号
  /// [placeholder] number 为 null 的返回值，占位符
  /// [needPercentSign] bool 为 true 是的需要百分号
  String? formatPercentString(
    int maxDigits, {
    int minDigits = 0,
    bool needNumSign = false,
    String placeholder = '--%',
    bool needPercentSign = true,
  }) {
    final result = double.tryParse(this ?? '');
    return result.formatPercentNumber(
      maxDigits,
      minDigits: minDigits,
      needNumSign: needNumSign,
      placeholder: placeholder,
      needPercentSign: needPercentSign,
    );
  }

  /// 根据规定小数点格式化为普通数值
  ///
  /// [maxDigits] 最大小数位数
  /// [minDigits] 最小小数位数
  /// [needNumSign] 是否显示 +、- 号
  /// [placeholder] number 为 null 的返回值，占位符
  String? formatNormalString(
    int maxDigits, {
    int minDigits = 0,
    bool needNumSign = false,
    String placeholder = '--',
  }) {
    final result = double.parse(this ?? '');
    return result.formatNormalNumber(
      maxDigits,
      minDigits: minDigits,
      needNumSign: needNumSign,
      placeholder: placeholder,
    );
  }

  /// String 不四舍五入
  ///
  /// [digits] 保留对应的小数位数
  String? noRoundDownString(int digits) {
    final num = double.tryParse(this ?? '');
    return num.noRoundDownNum(digits);
  }
}
