enum LocationState {
  locationNotSent, // 位置情報をサーバに未送信
  locationSent, // 位置情報をサーバに送信済み
  locationError, // 学食の近くにいない時のエラー
  timeError, // 位置情報を送信する時間外のエラー
  connectionError, // サーバとの通信エラー
  permissionError, // 位置情報パーミッションが許可されていないエラー
}
