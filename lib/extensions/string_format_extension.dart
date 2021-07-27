import 'package:template/extensions/num_format_extension.dart';

extension StringExtension on String? {
  String? formatFinancialString(
    int maxDigits, {
    int minDigits = 0,
    bool needNumSign = false,
    String placeholder = '--',
  }) {
    var result = double.tryParse(this ?? '');
    return result.formatFinancialNumber(
      maxDigits,
      minDigits: minDigits,
      needNumSign: needNumSign,
      placeholder: placeholder,
    );
  }

  String? formatPercentString(
    int maxDigits, {
    int minDigits = 0,
    bool needNumSign = false,
    String placeholder = '--%',
    bool needPercentSign = true,
  }) {
    var result = double.tryParse(this ?? '');
    return result.formatPercentNumber(
      maxDigits,
      minDigits: minDigits,
      needNumSign: needNumSign,
      placeholder: placeholder,
      needPercentSign: needPercentSign,
    );
  }

  /// 根据规定小数点格式化为普通字符串
  String? formatNormalString(
    int maxDigits, {
    int minDigits = 0,
    bool needNumSign = false,
    String placeholder = '--',
  }) {
    var result = double.parse(this ?? '');
    return result.formatNormalNumber(
      maxDigits,
      minDigits: minDigits,
      needNumSign: needNumSign,
      placeholder: placeholder,
    );
  }

  /// String 不四舍五入
  /// digits 保留对应的小数位数
  String? noRoundDownString(int digits) {
    var num = double.tryParse(this ?? '');
    return num.noRoundDownNum(digits);
  }
}
