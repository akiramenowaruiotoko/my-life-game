// countDownDateの処理を記述
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
};

// countDownDateの処理を記述
const countDownFreeTime = () => {
  // 元となるデータの取得
  const targetDate = document.getElementsByClassName('taget-date');
  // 出力先の要素を取得
  const addRmainingTime = document.getElementsByClassName("remaining-time");
  // 自由時間取得
  const freeTimeStr = document.getElementById("free-time").textContent;  
  // 繰り返し処理の回数を算出
  const targetCount = targetDate.length;  
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
    freeTime = rDays * freeTime;
    freeTime = rmainingTime - freeTime
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
};

// setintervalの値を保存する配列を用意する（ページ遷移の度に配列の値がリセットされない箇所に記述することに注意！）
let dateArray = new Array();
let timeArray = new Array();

// ページ読み込み時に読み込まれる記述をする
document.addEventListener("turbolinks:load", function() {
  // dateカウントダウン開始
  $("#remaining-date").on('click', function() {
    // 先に配列の値を全てshiftを繰り返しintervalを停止してfree-timeカウントダウンを停止させる
    if (timeArray.length > 0) {
      const timeArrayCount = timeArray.length;
      for (let x = 0; x < timeArrayCount; x++){
        clearInterval(timeArray.shift());
      };
    }
    // setintervalは１秒後に処理が行われる為、クリック後すぐに表示するように関数を記述
    countDownDate();
    // setintervalの値を配列に入れる
    dateArray.push(setInterval(countDownDate, 1000));
  });
  // free-timeカウントダウン開始
  $("#remaining-free-time").on('click', function() {
    // 先にdateカウントダウン停止
    if (dateArray.length > 0) {
      const dateArrayCount = dateArray.length;
      for (let y = 0; y < dateArrayCount; y++){
        clearInterval(dateArray.shift());
      };
    }
    countDownFreeTime();
    timeArray.push(setInterval(countDownFreeTime, 1000)); 
  });
});