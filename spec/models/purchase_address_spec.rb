require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
    sleep 0.1
  end
  
  describe '購入情報の保存' do
    context '商品を購入できる場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@purchase_address).to be_valid
      end
      it 'building_nameは空でも保存できる' do
        @purchase_address.building_name = ' '
        expect(@purchase_address).to be_valid
      end
    end

    context '商品を購入できない場合' do
      it 'tokenが空だと保存できない' do
        @purchase_address.token = ' '
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空だと保存できない' do
        @purchase_address.postal_code = ' '
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'prefectureを選択していないと保存できない' do
        @purchase_address.prefecture = ' '
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できない' do
        @purchase_address.city = ' '
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと保存できない' do
        @purchase_address.house_number = ' '
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと保存できない' do
        @purchase_address.phone_number = ' '
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'prefectureの選択が1だと保存できない' do
        @purchase_address.prefecture = '1'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'phone_numberがハイフンを含んでいると保存できない' do
        @purchase_address.phone_number = '080-0000-0000'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it 'phone_numberが10桁以下だと保存できない' do
        @purchase_address.phone_number = '030000000'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is too short")
      end
      it 'phone_numberが12桁以上だと保存できない' do
        @purchase_address.phone_number = '080000000000'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is too short")
      end
      it 'userが紐付いていないと保存できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
