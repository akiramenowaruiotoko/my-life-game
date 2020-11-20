require 'rails_helper'

RSpec.describe Fight, type: :model do
  describe 'ガンバ！登録' do
    before do
      @fight = FactoryBot.build(:fight)
    end
    context 'ガンバ！登録がうまくいきとき' do
      it 'user, targetが存在すれば登録できる' do
        expect(@fight).to be_valid
      end
    end
    context 'ガンバ！登録がうまくいかないとき' do
      it 'userが存在しないと登録できない' do
        @fight.user = nil
        @fight.valid?
        expect(@fight.errors.full_messages).to include("User must exist")
      end
      it 'targetが存在しないと登録できない' do
        @fight.target = nil
        @fight.valid?
        expect(@fight.errors.full_messages).to include("Target must exist")
      end
    end
  end
end
