/// @desc  日志输出
/// @time 2020/12/30
class LogUtil {

  ///是否 debug
  static bool debug = true; //是否是debug模式,true: log v 不输出.

  static const String tagDefault = '===MINE===';

  static void init({bool isDebug = false, String tag = tagDefault}) {
    debug = isDebug;
    tag = tag;
  }

  static void e(Object object, {String tag = tagDefault}) {
    _printLog(tag, '  e  ', object);
  }

  static void v(Object object, {String tag = tagDefault}) {
    if (debug) {
      _printLog(tag, '  v  ', object);
    }
  }

  static void _printLog(String tag, String stag, Object object) {
    var sb = StringBuffer();
    sb.write((tag.isEmpty) ? tagDefault : tag);
    sb.write(stag);
    sb.write(object);
    print(sb.toString());
  }
}