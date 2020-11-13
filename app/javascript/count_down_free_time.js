const countDownFreeTime = () => {
  // 元となるデータの取得
  const targetDate = document.getElementsByClassName('taget-date');
  // 出力先の要素を取得
  const addRmainingTime = document.getElementsByClassName("remaining-time");
  // 繰り返し処理の回数を算出
  const targetCount = targetDate.length;  
  // 自由時間取得
  const freeTimeStr = document.getElementById("free-time").textContent;  
  // 繰り返し処理の記述
  for (let i = 0; i < targetCount; i++ ){
    // 取得した自由時間の時間と分を数値で取り出し秒に変換（htmlに記述した空白もtextContentで取得しているので開始位置は１０から）
    const freeHour = freeTimeStr.substr(10, 2) * 3600;
    const freeMin = freeTimeStr.substr(13, 2) * 60; 
    let freeTime = freeHour + freeMin;

    // 取得した要素を日付に変換
    let targetDateValue = targetDate[i].textContent;
    targetDateValue = new Date(targetDateValue);    
    // 現在日時の取得
    let nowTime = new Date();
    // 取得した日時を秒に変換（時間調整するため）
    targetDateValue = targetDateValue.getTime();
    nowTime = nowTime.getTime();
    // 時間調整(目標日当日は期限内としたいため)
    targetDateValue += ( 60 * 60 * 24 * 1000);
    // 残り時間を計算
    let rmainingTime = targetDateValue - nowTime;
    // 1000ミリ秒を1秒に変換
    rmainingTime /= 1000;
    // 残り日数を算出
    let rDays = rmainingTime / ( 60 * 60 * 24);
    
    
    // 残り日数に自由時間を掛ける
    
    // ここがおかしい
    freeTime = rDays * freeTime;
    freeTime = rmainingTime - freeTime
    console.log(freeTime)


    // 残り時間を時間・分・秒に分割
    const rHour = freeTime / ( 60 * 60);
    freeTime = freeTime % ( 60 * 60);
    const rMin = freeTime / 60;
    freeTime = freeTime % 60;
    const rSec = freeTime;
    const result = Math.floor(rHour) + "時間"
    + Math.floor(rMin) + "分"
    + Math.floor(rSec) + "秒";
    // 表示文字列の作成
    let message;
    // 目標日がまだの場合とすぎた場合の表示切り替え
    if( targetDateValue > nowTime) {
      message = `残り自由時間は${result}です`;
    }
    else {
      message = `既に過ぎました`;
    }
    // 出力先に出力
    addRmainingTime[i].innerHTML =  message;
  };
  // カウントダウン開始
  const freeTimeButtom = document.getElementById("remaining-free-time");
  freeTimeButtom.addEventListener("click", () => {
    const id = setInterval(countDownFreeTime, 1000);
    
    // カウントダウン停止(dateに切り替え時)
    const dateButtom = document.getElementById("remaining-date");
    dateButtom.addEventListener("click", () => {
      clearInterval(id);
    });
  });
};
window.addEventListener("load", countDownFreeTime)