const countDownDate = () => {
  // 元となるデータの取得
  const targetDate = document.getElementsByClassName('taget-date');
  // 出力先の要素を取得
  const addRmainingTime = document.getElementsByClassName("remaining-time");
  // 繰り返し処理の回数を算出
  const targetCount = targetDate.length;
  // 繰り返し処理の記述

  for (let i = 0; i < targetCount; i++ ){
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
    // 目標日がすぎた場合は-1を掛けて正の値に変換        
    if( targetDateValue < nowTime) {
      rmainingTime *= -1;
    }
    // 残り時間を日数・時間・分・秒に分割
    const ryear = rmainingTime / ( 60 * 60 * 24 * 365);
    rmainingTime = rmainingTime % ( 60 * 60 * 24 * 365);
    const rDays = rmainingTime / ( 60 * 60 * 24);
    rmainingTime = rmainingTime % ( 60 * 60 * 24);
    const rHour = rmainingTime / ( 60 * 60);
    rmainingTime = rmainingTime % ( 60 * 60);
    const rMin = rmainingTime / 60;
    rmainingTime = rmainingTime % 60;
    const rSec = rmainingTime;
    const result = Math.floor(ryear) + "年"
    + Math.floor(rDays) + "日"
    + Math.floor(rHour) + "時間"
    + Math.floor(rMin) + "分"
    + Math.floor(rSec) + "秒";
    // 表示文字列の作成
    let message;
    // 目標日がまだの場合とすぎた場合の表示切り替え
    if( targetDateValue > nowTime) {
      message = `残り${result}です`;
    }
    else {
      message = `既に${result}前に過ぎました`;
    }
    // 出力先に出力
    addRmainingTime[i].innerHTML =  message;
  };

  // カウントダウン開始
  const dateButtom = document.getElementById("remaining-date");
  dateButtom.addEventListener("click", () => {
    const id = setInterval(countDownDate, 1000);
      
    // カウントダウン停止(free-timeに切り替え時)
    const freeTimeButtom = document.getElementById("remaining-free-time");
    freeTimeButtom.addEventListener("click", () => {
      clearInterval(id);
    });
  });
};
window.addEventListener("load", countDownDate)