import 'package:intl/intl.dart';

extension NumFormatExtension on num? {
  /// 根据规定小数点格式化为金融数值
  ///
  /// [maxDigits] 最大小数位数
  /// [minDigits] 最小小数位数
  /// [needNumSign] 是否强制显示+、-号
  /// [placeholder] number为null的返回值，占位符
  String formatFinancialNumber(
    int maxDigits, {
    int? minDigits,
    bool needNumSign = false,
    String placeholder = '--',
  }) {
    if (this == null) {
      return placeholder;
    }
    final format = NumberFormat('#,##0');
    format.maximumFractionDigits = maxDigits;
    format.minimumFractionDigits = minDigits ?? maxDigits;
    final result = format.format(this);
    if (needNumSign && this! > 0) {
      return '+$result';
    } else {
      return result;
    }
  }

  /// 根据规定小数点格式化为百分数
  ///
  /// [maxDigits] 最大小数位数
  /// [minDigits] 最小小数位数
  /// [needNumSign] 是否强制显示+、-号
  /// [placeholder] number为null的返回值，占位符
  /// [needPercentSign] bool 为true是的需要百分号
  String formatPercentNumber(
    int maxDigits, {
    int? minDigits,
    bool needNumSign = false,
    String placeholder = '--%',
    bool needPercentSign = true,
  }) {
    if (this == null) {
      return placeholder;
    }
    final format = NumberFormat('#.#%');
    format.maximumFractionDigits = maxDigits;
    format.minimumFractionDigits = minDigits ?? maxDigits;
    final result = needPercentSign
        ? format.format(this)
        : format.format(this).replaceAll('%', '');
    if (needNumSign && this! > 0) {
      return '+$result';
    } else {
      return result;
    }
  }

  /// 根据规定小数点格式化为普通数值
  ///
  /// [maxDigits] 最大小数位数
  /// [minDigits] 最小小数位数
  /// [needNumSign] 是否强制显示+、-号
  /// [placeholder] number为null的返回值，占位符
  String formatNormalNumber(
    int maxDigits, {
    int? minDigits,
    bool needNumSign = false,
    String placeholder = '--',
  }) {
    if (this == null) {
      return placeholder;
    }
    final format = NumberFormat('0.#');
    format.maximumFractionDigits = maxDigits;
    format.minimumFractionDigits = minDigits ?? maxDigits;
    final result = format.format(this);
    if (needNumSign && this! > 0) {
      return '+$result';
    } else {
      return result;
    }
  }

  /// num 不四舍五入
  ///
  /// [digits] 保留digits位小数位
  String noRoundDownNum(int digits) {
    if (this == null) {
      return '';
    }
    // 存在一个问题：最后一位是9的话就会出现忘上入，所以多+3位小数再截取
    digits += 3;
    final numStr = this!.toStringAsFixed(digits);
    return numStr.substring(0, numStr.lastIndexOf('.') + digits - 2);
  }

  /// 相乘返回规定小数点
  ///
  /// [multiplier] 被乘数
  /// [maxDigits] 最大小数位数
  /// [minDigits] 最小小数位数
  String multiply(num multiplier, int maxDigits, {int minDigits = 0}) {
    if (this == null) {
      return '';
    }
    return (this! * multiplier)
        .formatNormalNumber(maxDigits, minDigits: minDigits);
  }

  /// 相除返回规定小数点
  ///
  /// [divisor] 被除数
  /// [maxDigits] 最大小数位数
  /// [minDigits] 最小小数位数
  String divide(num divisor, int maxDigits, {int minDigits = 0}) {
    if (this == null) {
      return '';
    }
    if (divisor == 0) {
      throw UnsupportedError('divisor not zero');
    }
    return (this! / divisor)
        .formatNormalNumber(maxDigits, minDigits: minDigits);
  }
}
