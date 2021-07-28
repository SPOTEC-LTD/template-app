extension StringBusiness on String {
  String get innerScheme => 'template//';

  bool get isInnerUrl {
    return startsWith(innerScheme);
  }
}
