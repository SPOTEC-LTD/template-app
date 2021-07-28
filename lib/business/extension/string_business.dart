extension StringBusiness on String {
  bool get isInnerUrl {
    return startsWith('http://app.template.com') ||
        startsWith('https://app.template.com');
  }
}
