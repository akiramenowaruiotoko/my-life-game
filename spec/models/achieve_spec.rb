require 'rails_helper'

RSpec.describe Achieve, type: :model do
  describe 'achieve登録' do
    before do
      @achieve = FactoryBot.build(:achieve)
    end
    context 'achieve登録がうまくいくとき' do
      it 'targetが存在すれば登録できる' do
        expect(@achieve).to be_valid
      end
    end
    context 'achieve登録がうまくいかないとき' do
      it 'targetが存在しないと登録できる' do
        @achieve.target = nil
        @achieve.valid?
        expect(@achieve.errors.full_messages).to include("Target must exist")
      end
    end
  end
end
