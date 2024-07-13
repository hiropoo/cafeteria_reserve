class Strings {
  static const String username = "ユーザー名";
  static const String password = "パスワード";
  static const String studentID = "学籍番号";
  static const String confirmPassword = "パスワード (確認用)";

  static const String login = "ログイン";
  static const String signUp = "新規登録";

  static const String noAccount = "アカウントを持っていない場合";
  static const String alreadyHaveAccount = "アカウントを持っている場合";

  /* バリデーションメッセージ */
  static const usernameEmpty = "ユーザー名を入力してください";
  static const usernameSpace = "ユーザー名にスペースは使用できません";
  static const usernameNotAlphanumeric = "ユーザー名は半角英数字のみ使用できます";
  static const passwordEmpty = "パスワードを入力してください";
  static const passwordSpace = "パスワードにスペースは使用できません";
  static const studentIDEmpty = "学籍番号を入力してください";
  static const studentIDSpace = "学籍番号にスペースは使用できません";
  static const confirmPasswordEmpty = "確認用パスワードを入力してください";
  static const passwordMatch = "パスワードが一致しません";

  // 位置情報送信メッセージ
  static const String locationDescription = '''位置情報を送信して、予約の利用を証明してください。\n\n位置情報の送信は、予約開始時間の5分前から、予約終了時間の5分後まで可能です。
                ''';
}
