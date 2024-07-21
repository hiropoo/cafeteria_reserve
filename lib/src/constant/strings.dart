class Strings {
  static const String appName = '学食スワローズ';

  static const String username = 'ユーザー名';
  static const String password = 'パスワード';
  static const String studentID = '学籍番号';
  static const String confirmPassword = 'パスワード (確認用)';
  static const String friendID = '友だちのID';

  /* ログイン 新規登録メッセージ */
  static const String login = 'ログイン';
  static const String signUp = '新規登録';
  static const String loginFailed = 'ユーザー名またはパスワードが間違っています';
  static const String signUpFailed = '新規登録に失敗しました';

  static const String noAccount = 'アカウントをお持ちでない場合';
  static const String alreadyHaveAccount = 'すでにアカウントをお持ちの方';

  /* 新規登録時のダイアログ */
  static const String signUpCompleted = '新規登録';
  static const String signUpCompletedMessage = '新規登録が完了しました';
  static const String dialogConfirm = 'OK';

  /* バリデーションメッセージ */
  static const String usernameEmpty = 'ユーザー名を入力してください';
  static const String usernameSpace = 'ユーザー名にスペースは使用できません';
  static const String usernameNotAlphanumeric = 'ユーザー名は半角英数字のみ使用できます';
  static const String passwordEmpty = 'パスワードを入力してください';
  static const String passwordSpace = 'パスワードにスペースは使用できません';
  static const String studentIDEmpty = '学籍番号を入力してください';
  static const String studentIDSpace = '学籍番号にスペースは使用できません';
  static const String confirmPasswordEmpty = '確認用パスワードを入力してください';
  static const String passwordMatch = 'パスワードが一致しません';
  static const String studentIDNotNumeric = '学籍番号は半角数字のみ使用できます';

  /* 位置情報送信メッセージ */
  static const String locationSend = '位置情報を送信';
  static const String locationSendResult = '位置情報を送信しました';
  static const String locationDescription = '''位置情報を送信して、予約の利用を証明してください。\n\n位置情報の送信は、予約開始時間の5分前から、予約終了時間の5分後まで可能です。\n\n時間内に位置情報を送信しなかった場合、ペナルティとなり2週間の利用制限がかかります。''';
  static const String timeError = '現在位置情報の送信はできません';
  static const String locationError = '予約した学食の近くにいることを確認してください';
  static const String connectionError = '通信エラーが発生しました';
  static const String permissionError = '位置情報の利用が許可されていません';
}
