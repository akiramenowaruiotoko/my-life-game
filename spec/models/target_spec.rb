require 'rails_helper'

RSpec.describe Target, type: :model do
  describe 'ユーザー登録' do
    before do
      @target = FactoryBot.build(:target)
    end
    context '目標設定がうまくいくとき' do
      it 'content, target_date, userが存在すれば登録できる' do
        expect(@target).to be_valid
      end
    end

    context '目標設定がうまくいかないとき' do
      it 'contentが空では設定できない' do
        @target.content = nil
        @target.valid?
        expect(@target.errors.full_messages).to include("Content can't be blank")
      end
      it 'target_dateが空では設定できない' do
        @target.target_date = nil
        @target.valid?
        expect(@target.errors.full_messages).to include("Target date can't be blank")
      end
      it 'userが空では設定できない' do
        @target.user = nil
        @target.valid?
        expect(@target.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
