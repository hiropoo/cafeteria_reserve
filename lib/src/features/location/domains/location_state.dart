enum LocationState {
  noReservation,    // 予約がないので位置情報を送信するボタンは非表示
  locationNotSent,  // 位置情報をサーバに未送信  
  locationSent,     // 位置情報をサーバに送信済み
  error,            // エラー
}