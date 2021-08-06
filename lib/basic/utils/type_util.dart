class TypeUtil {
  static T? safeCast<T>(dynamic value) {
    if (value is T) {
      return value;
    }
    return null;
  }
}
