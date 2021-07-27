// import 'package:flutter/services.dart';
// import 'package:template/util/regex_util.dart';

// ///@desc 验证扩展，主要用于验证手机，邮箱，密码等格式
// extension VerifyBoolExtension on String {
//   static final int fastClickDelayTime = 1000;
//   static int lastClickTime = 0;

//   /// 两次点击间隔不能少于1000ms,防止连续点击
//   static bool isFastClick() {
//     var flag = true;
//     var currentClickTime = DateTime.now().millisecondsSinceEpoch;

//     if ((currentClickTime - lastClickTime) >= fastClickDelayTime) {
//       flag = false;
//     }
//     lastClickTime = currentClickTime;
//     return flag;
//   }

//   /// 不允许输入特殊字符
//   static FilteringTextInputFormatter get denySpecialChars {
//     return FilteringTextInputFormatter.allow(RegExp(
//         r"[`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]"));
//   }

//   /// 不允许输入中文、空格
//   static FilteringTextInputFormatter get denyChinessBlank {
//     return FilteringTextInputFormatter.deny(
//         RegExp(r'[\u4e00-\u9fa5\u00A0\u0020\u3000]'));
//   }

//   /// 只允许输入中文、数字、字母
//   static FilteringTextInputFormatter get allowChinessNumberLetters {
//     return FilteringTextInputFormatter.allow(
//         RegExp(r'[\u4E00-\u9FA5A-Za-z0-9]'));
//   }

//   /// 只允许输入数字、字母
//   static FilteringTextInputFormatter get allowNumberLetters {
//     return FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]'));
//   }

//   /// 只允许输入数字
//   static FilteringTextInputFormatter get allowNumbers {
//     return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
//   }

//   ///验证phone
//   bool verifyPhone(bool isChina) {
//     if (isChina) {
//       return RegexUtil.isMobileExact(this);
//     } else {
//       return isNotEmpty && length <= 11;
//     }
//   }

//   ///验证email
//   bool verifyEmail() {
//     return isNotEmpty && length <= 100 && RegexUtil.isEmail(this);
//   }

//   ///验证密码
//   bool verifyPwd() {
//     return isNotEmpty && RegexUtil.isPwd(this);
//   }
// }
