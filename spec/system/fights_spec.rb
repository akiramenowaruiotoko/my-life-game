require 'rails_helper'

RSpec.describe "fights登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @target = FactoryBot.create(:target)
  end
  context 'fight登録ができるとき' do
  it 'ターゲットのガンバ！ far fa-heartアイコンをクリックするとfight登録できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      #ターゲット登録済みユーザーのshowページに遷移する
      visit target_path(@target.user_id)
      # ガンバ！ far fa-heartアイコンをクリックする
      find('i.far.fa-heart').click
      # 元のページのままなことを確認する
      expect(current_path).to eq target_path(@target.user_id)
      # showページにはガンバ！ fas fa-heartアイコンに切り替わっていることを確認する
      expect(page).to have_no_css('i.far.fa-heart')
      expect(page).to have_css('i.fas.fa-heart')
    end
  end
  context 'fight登録ができないとき'do
    it 'ログインしないとターゲットのガンバ！ far fa-heartアイコンが表示されずfight登録できない' do
      #ターゲット登録済みユーザーのshowページに遷移する
      visit target_path(@target.user_id)
      # ガンバ！ far fa-heartアイコンが表示されないことを確認する
      expect(page).to have_no_css('i.far.fa-heart')
    end
  end
end

RSpec.describe "fights削除", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @target = FactoryBot.create(:target)
  end
  context 'fight削除ができるとき' do
  it 'ターゲットのガンバ！ fas fa-heartアイコンをクリックするとfight削除できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      #ターゲット登録済みユーザーのshowページに遷移する
      visit target_path(@target.user_id)
      # ガンバ！ far fa-heartアイコンをクリックする
      find('i.far.fa-heart').click
      # ガンバ！ fas fa-heartアイコンをクリックする
      find('i.fas.fa-heart').click
      # 元のページのままなことを確認する
      expect(current_path).to eq target_path(@target.user_id)
      # showページにはガンバ！ far fa-heartアイコンに切り替わっていることを確認する
      expect(page).to have_no_css('i.fas.fa-heart')
      expect(page).to have_css('i.far.fa-heart')
    end
  end
  context 'fight削除ができないとき'do
    it 'ログインしないとターゲットのガンバ！ fas fa-heartアイコンが表示されずfight削除できない' do
      #ターゲット登録済みユーザーのshowページに遷移する
      visit target_path(@target.user_id)
      # ガンバ！ fas fa-heartアイコンが表示されないことを確認する
      expect(page).to have_no_css('i.fas.fa-heart')
    end
  end
end