extension StringIsEmptyExtension on String? {
  /// 传入值为null或者长度为0，则返回true
  bool get isEmptyString => (this ?? '').isEmpty;

  /// 传入值不为null或者长度大于0，则返回true
  bool get isNotEmptyString => !isEmptyString;
}

extension ListIsEmptyExtension on List? {
  /// 传入值为null或者长度为0，则返回true
  bool get isEmptyList => (this ?? []).isEmpty;

  /// 传入值不为null或者长度大于0，则返回true
  bool get isNotEmptyList => !isEmptyList;
}

extension MapIsEmptyExtension on Map? {
  /// 传入值为null或者长度为0，则返回true
  bool get isEmptyMap => (this ?? {}).isEmpty;

  /// 传入值不为null或者长度大于0，则返回true
  bool get isNotEmptyMap => !isEmptyMap;
}
