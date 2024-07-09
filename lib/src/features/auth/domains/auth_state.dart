enum AuthState {
  loggedOut,  // ローカル内にログイン情報があるが、前回ログアウトしている場合は、ログイン画面を表示
  signUp,     // ローカル内にユーザ情報が存在しない場合は、新規登録画面を表示
  loggedIn,   // ローカル内にログイン情報があり前回ログアウトしていない場合は、、自動でログインしてホーム画面を表示
}