require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('sign-up')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      # free-timeは初期値00:00で設定してあるので選択しなくても問題ないが別の値を選択
      find("#user_free_time_4i").find("option[value='12']").select_option
      find("#user_free_time_5i").find("option[value='30']").select_option
      #プライベートモードをクリックするとチェックされる
      find("#user_private_mode").click
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content('log-out')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('sign-up')
      expect(page).to have_no_content('log-in')    
      # プライベートモードにチェックをしたユーザーの名前が表示されていないことを確認する
      expect(page).to have_no_content(@user.name)
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('sign-up')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を空で入力する
      fill_in 'Name', with: ""
      fill_in 'Email', with: ""
      fill_in 'Password', with: ""
      fill_in 'Password confirmation', with: ""
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('log-in')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content('log-out')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('sign-up')
      expect(page).to have_no_content('log-in')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('log-in')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'Email', with: ""
      fill_in 'Password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'ユーザー編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context '編集ができるとき' do
    it '正しい情報を入力すればユーザー編集ができてトップページに移動する' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページにユーザー編集ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('user-edit')
      # ユーザー編集ページへ移動する
      visit edit_user_registration_path
      # ユーザー情報を変更（nameを変更）する
      fill_in 'Name', with: "hoge"
      # Currentパスワードを入力する
      fill_in 'Current password', with: @user.password
      # アップデートボタンを押してもユーザーモデルのカウントが1上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content('log-out')
      # トップページに変更したnameが表示されることを確認する
      expect(page).to have_content('hoge')
    end
  end
  context '編集ができないとき' do
    it 'Current passwordを入力しないとユーザー編集ができずユーザー編集ページへ戻ってくる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページにユーザー編集ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('user-edit')
      # ユーザー編集ページへ移動する
      visit edit_user_registration_path
      # ユーザー情報を変更（nameを変更）する
      fill_in 'Name', with: "hoge"
      # Currentパスワードを入力しない
      fill_in 'Current password', with: ""
      # アップデートボタンを押してもユーザーモデルのカウントが1上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
      # ユーザー編集ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end