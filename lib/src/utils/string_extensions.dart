extension StringEx on String {
  /// 英数字と大文字小文字のみを受け付ける正規表現バリデーション
  bool isValidAlphanumeric() {
    return RegExp(
      r'^[a-zA-Z0-9]+$',
    ).hasMatch(this);
  }

  /// 数字のみを受け付ける正規表現バリデーション
  bool isValidNumeric() {
    return RegExp(
      r'^[0-9]+$',
    ).hasMatch(this);
  }
}
