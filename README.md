# My Life Game

## Overview
人生におけるタスク管理アプリケーション  
ゴールにむけてステータスを増やして行こう

*目標には期日を設け、残り日時を表示させることができる  
*１日の自由時間を設定し、残り時間を表示させることができる  
*目標は公開/非公開することができる  
*達成した目標はステータスに反映させることができる  
*目標に対してガンバ！（いいね）できる

## DEMO

![ffe4283a94205e1a846f44bfb4744c2b](https://user-images.githubusercontent.com/72367383/100053135-bbf4fe00-2e62-11eb-9bea-2f86892b032b.gif)


## URL

https://my-life-game.herokuapp.com/

## テスト用アカウント

Email: hoge@com  
Password: hhhhhh

## 利用方法

*閲覧・応援  
 サイドバーのnameをクリックしユーザー毎の一覧を見る  
 countdownの日時または自由時間のアイコンをクリックし残り時間を表示できる  
 目標毎のガンバ！♡アイコンをクリックし応援する  
  
*投稿  
 Sign upまたはLog inし、マイページをクリック  
 フォームの期日を選択、目標を入力し、送信ボタンをクリック  
 達成した目標はGET□アイコンをクリックしステータスに反映する

## 目指した課題解決

目標はあるが期日がなく実行に移せずに時間だけが過ぎてしまう人の課題を解決

## 洗い出した要件

*目標投稿機能  
*目標期日設定機能  
*日時カウントダウン機能  
*自由時間カウントダウン機能  
*ユーザー管理機能  
*公開・非公開機能  
*いいね機能  
*ステータス機能

## テーブル設計

<img width="625" alt="ER図 MyLifeGame" src="https://user-images.githubusercontent.com/72367383/100050638-33279380-2e5d-11eb-866d-5d672f1a13eb.png">

## ローカルでの動作方法

Rails version 6.0.3.4  
Ruby Version 2.6.5  
Database adapter mysql2