require 'rails_helper'
describe TargetsController, type: :request do

  before do
    @user = FactoryBot.create(:user)
    @target = FactoryBot.create(:target)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストすると登録済みのユーザーが存在する" do 
      get root_path
      expect(response.body).to include @user.name
    end
  end
  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
      get target_path(@target.user_id)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストするとレスポンスに投稿済みのターゲットのcontentが存在する" do
      get target_path(@target.user_id)
      expect(response.body).to include @target.content
    end
    it "showアクションにリクエストするとレスポンスに投稿済みのターゲットのtarget_dateが存在する" do
      get target_path(@target.user_id)
      expect(response.body).to include @target.target_date.to_s
    end
  end
  describe "GET #new" do
    it "未ログインユーザーがnewアクションにリクエストするとレスポンスのステータスが302で返ってくる" do
      get new_target_path
      expect(response.status).to eq 302
    end
    it "未ログインユーザーがnewアクションにリクエストするとログインページへ遷移する" do
      get new_target_path
      expect(response).to redirect_to new_user_session_path
    end
  end
  describe "POST #create" do
    it "未ログインユーザーがcreateアクションにリクエストするとレスポンスのステータスが302で返ってくる" do
      post targets_path
      expect(response.status).to eq 302
    end
    it "未ログインユーザーがcreateアクションにリクエストするとログインページへ遷移する" do
      post targets_path
      expect(response).to redirect_to new_user_session_path
    end
  end
  describe "GET #edit" do
    it "未ログインユーザーがeditアクションにリクエストするとレスポンスのステータスが302で返ってくる" do
      get edit_target_path(@target)
      expect(response.status).to eq 302
    end
    it "未ログインユーザーがeditアクションにリクエストするとログインページへ遷移する" do
      get edit_target_path(@target)
      expect(response).to redirect_to new_user_session_path
    end
  end
  describe "PUT #update" do
    it "未ログインユーザーがupdateアクションにリクエストするとレスポンスのステータスが302で返ってくる" do
      put target_path(@target)
      expect(response.status).to eq 302
    end
    it "未ログインユーザーがupdateアクションにリクエストするとログインページへ遷移する" do
      put target_path(@target)
      expect(response).to redirect_to new_user_session_path
    end
  end
  describe "DELETE #destroy" do
    it "未ログインユーザーがdestroyアクションにリクエストするとレスポンスのステータスが302で返ってくる" do
      delete target_path(@target)
      expect(response.status).to eq 302
    end
    it "未ログインユーザーがdestroyアクションにリクエストするとログインページへ遷移する" do
      delete target_path(@target)
      expect(response).to redirect_to new_user_session_path
    end
  end

end
