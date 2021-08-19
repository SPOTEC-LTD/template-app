// Author: Dean.Liu
// DateTime: 2021/08/12 18:44

import 'package:intl/intl.dart';

/// 日期的格式化类型
enum DateFormatType {
  // yyyy-MM-dd HH:mm:ss.SSS
  ymdhmss,
  // yyyy-MM-dd HH:mm:ss
  ymdhms,
  // yyyy-MM-dd HH:mm
  ymdhm,
  // yyyy-MM-dd
  ymd,
  // yyyy-MM
  ym,
  // MM-dd HH:mm
  mdhm,
  // MM-dd
  md,
  // HH:mm:ss
  hms,
  // HH:mm
  hm,
}

extension _DateFormatTypeExtension on DateFormatType {
  String get name {
    switch (this) {
      case DateFormatType.ymdhmss:
        return 'yyyy-MM-dd HH:mm:ss.SSS';
      case DateFormatType.ymdhms:
        return 'yyyy-MM-dd HH:mm:ss';
      case DateFormatType.ymdhm:
        return 'yyyy-MM-dd HH:mm';
      case DateFormatType.ymd:
        return 'yyyy-MM-dd';
      case DateFormatType.ym:
        return 'yyyy-MM';
      case DateFormatType.mdhm:
        return 'MM-dd HH:mm';
      case DateFormatType.md:
        return 'MM-dd';
      case DateFormatType.hms:
        return 'HH:mm:ss';
      case DateFormatType.hm:
        return 'HH:mm';
    }
  }
}

/// 将 String 转化为日期
extension StringDateExtension on String? {
  /// 将日期字符串转换为 DateTime 对象
  DateTime? toDateTime() {
    if (this == null) {
      return null;
    }
    return DateTime.parse(this!);
  }

  /// 格式化日期字符串
  ///
  /// [type] 格式化的类型
  /// [timeSeparater] 时分秒之间的分隔符
  /// [placeholder] 当前字符串无法转为日期时的占位符
  String toFormattedDateTime({
    DateFormatType type = DateFormatType.ymdhms,
    String? dateSeparater,
    String? timeSeparater,
    String placeholder = '',
  }) {
    final dateTime = toDateTime();
    if (dateTime == null) {
      return placeholder;
    }
    var pattern = type.name;
    if (dateSeparater != null) {
      pattern = pattern.replaceAll('-', dateSeparater);
    }
    if (timeSeparater != null) {
      pattern = pattern.replaceAll(':', timeSeparater);
    }
    return DateFormat(pattern).format(dateTime);
  }
}

/// 时间戳的格式类型
enum TimestampType {
  // 毫秒
  milli,
  // 微秒
  micro,
}

/// 将 int 转化为日期
extension IntDateTimeExtension on int? {
  /// 将时间戳转换为 DateTime 对象
  DateTime? toDateTime({TimestampType type = TimestampType.milli}) {
    if (this == null) {
      return null;
    }
    switch (type) {
      case TimestampType.milli:
        return DateTime.fromMillisecondsSinceEpoch(this!);
      case TimestampType.micro:
        return DateTime.fromMicrosecondsSinceEpoch(this!);
    }
  }

  /// 将时间戳格式化为日期字符串
  ///
  /// [formateType] 格式化的类型
  /// [stampType] 时间戳是毫秒还是微秒
  /// [dateSeparater] 年月日之间的分隔符
  /// [timeSeparater] 时分秒之间的分隔符
  /// [placeholder] 当前字符串无法转为日期时的占位符
  String toFormattedDateTime({
    DateFormatType formateType = DateFormatType.ymdhms,
    TimestampType stampType = TimestampType.milli,
    String? dateSeparater,
    String? timeSeparater,
    String placeholder = '',
  }) {
    final dateTime = toDateTime(type: stampType);
    if (dateTime == null) {
      return placeholder;
    }
    var pattern = formateType.name;
    if (dateSeparater != null) {
      pattern = pattern.replaceAll('-', dateSeparater);
    }
    if (timeSeparater != null) {
      pattern = pattern.replaceAll(':', timeSeparater);
    }
    return DateFormat(pattern).format(dateTime);
  }
}
