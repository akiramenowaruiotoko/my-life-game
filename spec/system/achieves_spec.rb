require 'rails_helper'

RSpec.describe "achieves登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @target = FactoryBot.create(:target)
    @target_content = Faker::Lorem.sentence
  end
  context 'achieve登録ができるとき'do
  it 'ターゲットのGET squareアイコンをクリックするとachieve登録できる' do
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
      # GET squareアイコンをクリックしAchieveモデルのカウントが1上がることを確認する
      expect{
        find('i.far.fa-square').click
      }.to change { Achieve.count }.by(1)
      # マイページに戻ってくることを確認する
      expect(current_path).to eq new_target_path
      # マイページにはGET check-squareアイコンに切り替わっていることを確認する
      expect(page).to have_no_css('i.far.fa-square')
      expect(page).to have_css('i.fas.fa-check-square')
    end
  end
  context 'achieve登録ができないとき'do
    it '登録したユーザー以外はターゲットのGET squareアイコンが表示されずachieve登録できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      #ターゲット登録済みユーザーのshowページに遷移する
      visit target_path(@target.user_id)
      # GET squareアイコンが表示されないことを確認する
      expect(page).to have_no_css('i.far.fa-square')
    end
  end
end

RSpec.describe "achieves削除", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @target = FactoryBot.create(:target)
    @target_content = Faker::Lorem.sentence
  end
  context 'achieve削除ができるとき'do
  it 'ターゲットのGET check-squareアイコンをクリックするとachieve削除できる' do
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
      # achieve登録する
      find('i.far.fa-square').click
      expect(current_path).to eq new_target_path
      # GET check-squareアイコンをクリックしAchieveモデルのカウントが1下がることを確認する
      expect{
        find('i.fas.fa-check-square').click
      }.to change { Achieve.count }.by(-1)
      # マイページに戻ってくることを確認する
      expect(current_path).to eq new_target_path
      # マイページにはGET squareアイコンに切り替わっていることを確認する
      expect(page).to have_no_css('i.fas.fa-check-square')
      expect(page).to have_css('i.far.fa-square')
    end
  end
  context 'achieve削除ができないとき'do
    it '登録したユーザー以外はターゲットのGET check-squareアイコンが表示されずachieve削除できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      #ターゲット登録済みユーザーのshowページに遷移する
      visit target_path(@target.user_id)
      # GET check-squareアイコンが表示されないことを確認する
      expect(page).to have_no_css('i.fas.fa-check-square')
    end
  end
end