// Author: Dean.Liu
// DateTime: 2021/08/12 18:44
// Description: 通过 Duration 计算剩余的天、时、分、秒、毫秒、微秒，类似取余操作

/// 通过 Duration 计算剩余的天、时、分、秒、毫秒、微秒，类似取余操作
///
/// 如 123 秒，inMinutesRest 为 2 分，inSecondsRest 为 3 秒
extension RestTimeOnDuration on Duration {
  /// 还剩多少天
  int get inDaysRest => inDays;

  /// 去除天后还剩多少小时
  int get inHoursRest => inHours - (inDays * 24);

  /// 去除小时还剩多少分钟
  int get inMinutesRest => inMinutes - (inHours * 60);

  /// 去除分钟还剩多少秒
  int get inSecondsRest => inSeconds - (inMinutes * 60);

  /// 去除秒还剩多少毫秒
  int get inMillisecondsRest => inMilliseconds - (inSeconds * 1000);

  /// 去除毫秒还剩多少微秒
  int get inMicrosecondsRest => inMicroseconds - (inMilliseconds * 1000);
}
