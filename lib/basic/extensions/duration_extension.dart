/// 通过 Duration 计算剩余的 天、时、分、秒、毫秒、微秒
///
/// 如 123秒，转换为 2分3秒
extension RestTimeOnDuration on Duration {
  int get inDaysRest => inDays;
  int get inHoursRest => inHours - (inDays * 24);
  int get inMinutesRest => inMinutes - (inHours * 60);
  int get inSecondsRest => inSeconds - (inMinutes * 60);
  int get inMillisecondsRest => inMilliseconds - (inSeconds * 1000);
  int get inMicrosecondsRest => inMicroseconds - (inMilliseconds * 1000);
}
