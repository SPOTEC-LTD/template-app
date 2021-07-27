/// 日期格式化
enum DateFormat {
  def, // yyyy-MM-dd HH:mm:ss.SSS
  normal, // yyyy-MM-dd HH:mm:ss
  year_month_day_hour_minute, // yyyy-MM-dd HH:mm
  year_month_day, // yyyy-MM-dd
  year_month, // yyyy-MM
  month_day, // MM-dd
  month_day_hour_minute, // MM-dd HH:mm
  hour_minute_second, // HH:mm:ss
  hour_minute, // HH:mm
}

/// 对1970-01-01T00:00:00Z 类似格式进行扩展
extension DateExtension on String {
  /// format DateTime.
  /// this            time string. 格式yyyy-MM-dd HH:mm:ss
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  String? formatDateTime({
    required DateFormat? format,
    required String? dateSeparate,
    required String? timeSeparate,
  }) {
    String time = '';
    switch (format) {
      case DateFormat.normal: // yyyy-MM-dd HH:mm:ss
        time = substring(0, 'yyyy-MM-dd HH:mm:ss'.length);
        break;
      case DateFormat.year_month_day_hour_minute: // yyyy-MM-dd HH:mm
        time = substring(0, 'yyyy-MM-dd HH:mm'.length);
        break;
      case DateFormat.year_month_day: // yyyy-MM-dd
        time = substring(0, 'yyyy-MM-dd'.length);
        break;
      case DateFormat.year_month: // yyyy-MM
        time = substring(0, 'yyyy-MM'.length);
        break;
      case DateFormat.month_day: // MM-dd
        time = substring('yyyy-'.length, 'yyyy-MM-dd'.length);
        break;
      case DateFormat.month_day_hour_minute: // MM-dd HH:mm
        time = substring('yyyy-'.length, 'yyyy-MM-dd HH:mm'.length);
        break;
      case DateFormat.hour_minute_second: // HH:mm:ss
        time = substring('yyyy-MM-dd '.length, 'yyyy-MM-dd HH:mm:ss'.length);
        break;
      case DateFormat.hour_minute: // HH:mm
        time = substring('yyyy-MM-dd '.length, 'yyyy-MM-dd HH:mm'.length);
        break;
      default:
        break;
    }
    return dateTimeSeparate(time, dateSeparate, timeSeparate);
  }

  /// date Time Separate.
  String? dateTimeSeparate(
      String? time, String? dateSeparate, String? timeSeparate) {
    if (dateSeparate != null) {
      time = time!.replaceAll('-', dateSeparate);
    }
    if (timeSeparate != null) {
      time = time!.replaceAll(':', timeSeparate);
    }
    return time;
  }
}

/// 对时间戳进行扩展 int
extension IntTimeStampExtension on int {
  /// format DateTime.
  /// this            time string. 格式yyyy-MM-dd HH:mm:ss
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  String? formatTimeStamp({
    required DateFormat format,
    required String dateSeparate,
    required String timeSeparate,
  }) {
    //转换成1970-01-01T00:00:00Z 格式
    var date = DateTime.fromMillisecondsSinceEpoch(this).toString();
    return date.formatDateTime(
        format: format, dateSeparate: dateSeparate, timeSeparate: timeSeparate);
  }
}

/// 对时间戳进行扩展 String
extension StringTimeStampExtension on String {
  /// format DateTime.
  /// this            time string. 格式yyyy-MM-dd HH:mm:ss
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  String? formatTimeStamp({
    required DateFormat format,
    required String dateSeparate,
    required String timeSeparate,
  }) {
    var time = int.tryParse(this) ?? 0;
    // 转换成1970-01-01T00:00:00Z 格式
    var date = DateTime.fromMillisecondsSinceEpoch(time).toString();
    return date.formatDateTime(
        format: format, dateSeparate: dateSeparate, timeSeparate: timeSeparate);
  }
}
