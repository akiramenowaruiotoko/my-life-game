require 'rails_helper'
describe FightsController, type: :request do
  before do
    @target = FactoryBot.create(:target)
    @fight = FactoryBot.create(:fight)
  end

  describe "POST #create" do
    it "未ログインユーザーがcreateアクションにリクエストするとレスポンスのステータスが302で返ってくる" do
      post target_fights_path(@target)
      expect(response.status).to eq 302
    end
    it "未ログインユーザーがcreateアクションにリクエストするとログインページへ遷移する" do
      post target_fights_path(@target)
      expect(response).to redirect_to new_user_session_path
    end
  end
  describe "DELETE #destroy" do
    it "未ログインユーザーがdestroyアクションにリクエストするとレスポンスのステータスが302で返ってくる" do
      delete target_fight_path(@target, @target)
      expect(response.status).to eq 302
    end
    it "未ログインユーザーがdestroyアクションにリクエストするとログインページへ遷移する" do
      delete target_fight_path(@target, @target)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
