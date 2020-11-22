require 'rails_helper'

RSpec.describe 'ターゲット登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @target_content = Faker::Lorem.sentence
  end
  context 'ターゲット登録ができるとき'do
    it 'ログインしたユーザーはマイページへ遷移でき、ターゲット登録できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # マイページへのリンクがあることを確認する
      expect(page).to have_content('マイページ')
      # マイページに移動する
      visit new_target_path
      # フォームに情報を入力する
      find("#target_target_date_1i").find("option[value='2021']").select_option
      find("#target_target_date_2i").find("option[value='5']").select_option
      find("#target_target_date_3i").find("option[value='15']").select_option
      fill_in '目標またはステータスを入力', with: @target_content
      # 送信するとTargetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Target.count }.by(1)
      # マイページに戻ってくることを確認する
      expect(current_path).to eq new_target_path
      # マイページには先ほど投稿した内容のターゲットが存在することを確認する
      expect(page).to have_content('2021-05-15')
      expect(page).to have_content(@target_content)
    end
  end
  context 'ターゲット登録ができないとき'do
    it 'ログインしていないとマイページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # マイページへのリンクがない
      expect(page).to have_no_content('マイページ')
    end
  end
end

RSpec.describe 'ターゲット編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @target_content = Faker::Lorem.sentence
  end
  context 'ターゲット編集ができるとき'do
    it '空以外の情報を入力したターゲットは編集できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ターゲットを登録する
      visit new_target_path
      find("#target_target_date_1i").find("option[value='2021']").select_option
      find("#target_target_date_2i").find("option[value='5']").select_option
      find("#target_target_date_3i").find("option[value='15']").select_option
      fill_in '目標またはステータスを入力', with: @target_content
      find('input[name="commit"]').click
      # ターゲット編集アイコンをクリックする
      find('.target-edit').click
      # 編集ページへ遷移したことを確認する
      expect(current_path).to eq edit_target_path(@user.targets.ids)
      # ターゲット情報を編集する
      fill_in '目標またはステータスを入力', with: 'hoge'
      # 送信してもTargetモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Target.count }.by(0)
      # マイページに戻ってくることを確認する
      expect(current_path).to eq new_target_path
      # マイページには先ほど投稿した内容のターゲットが存在することを確認する
      expect(page).to have_content('2021-05-15')
      expect(page).to have_content('hoge')
    end
  end
  context 'ターゲット編集ができないとき'do
    it '空の情報を入力したターゲットは編集できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ターゲットを登録する
      visit new_target_path
      find("#target_target_date_1i").find("option[value='2021']").select_option
      find("#target_target_date_2i").find("option[value='5']").select_option
      find("#target_target_date_3i").find("option[value='15']").select_option
      fill_in '目標またはステータスを入力', with: @target_content
      find('input[name="commit"]').click
      # ターゲット編集アイコンをクリックする
      find('.target-edit').click
      # 編集ページへ遷移したことを確認する
      expect(current_path).to eq edit_target_path(@user.targets.ids)
      # ターゲット情報を空に編集する
      fill_in '目標またはステータスを入力', with: ""
      # 送信してもTargetモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Target.count }.by(0)
      # 編集ページに戻ってくることを確認する
      expect(current_path).to eq edit_target_path(@user.targets.ids)
      # マイページには元々投稿した内容のターゲットが存在することを確認する
      expect(page).to have_content('2021-05-15')
      expect(page).to have_content(@target_content)
    end
  end
end

RSpec.describe 'ターゲット削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @target_content = Faker::Lorem.sentence
  end
  context 'ターゲット削除ができるとき'do
    it '削除アイコンをクリックして表示されるconfirmをOKすると削除できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ターゲットを登録する
      visit new_target_path
      find("#target_target_date_1i").find("option[value='2021']").select_option
      find("#target_target_date_2i").find("option[value='5']").select_option
      find("#target_target_date_3i").find("option[value='15']").select_option
      fill_in '目標またはステータスを入力', with: @target_content
      find('input[name="commit"]').click
      # ターゲット削除アイコンをクリックする
      find('.target-delete').click
      # 表示されるconfirmをOKすると削除できTargetモデルのカウントが1下がり、投稿したターゲットが存在しない
      expect{
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_no_content('2021-05-15')
          expect(page).to have_no_content(@target_content)
      }.to change { Target.count }.by(-1)
      # マイページへ遷移したことを確認する
      expect(current_path).to eq new_target_path
    end
    it '削除アイコンをクリックして表示されるconfirmをキャンセルすると削除できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ターゲットを登録する
      visit new_target_path
      find("#target_target_date_1i").find("option[value='2021']").select_option
      find("#target_target_date_2i").find("option[value='5']").select_option
      find("#target_target_date_3i").find("option[value='15']").select_option
      fill_in '目標またはステータスを入力', with: @target_content
      find('input[name="commit"]').click
      # ターゲット削除アイコンをクリックする
      find('.target-delete').click
      # 表示されるconfirmをキャンセルすると削除できずTargetモデルのカウントは減らず、投稿したターゲットが存在する
      expect{
          page.driver.browser.switch_to.alert.dismiss
          expect(page).to have_content('2021-05-15')
          expect(page).to have_content(@target_content)
      }.to change { Target.count }.by(0)
      # マイページへ遷移したことを確認する
      expect(current_path).to eq new_target_path
    end
  end
end