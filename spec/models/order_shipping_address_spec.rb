require 'rails_helper'

  RSpec.describe OrderShippingAddress, type: :model do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: @user.id, item_id: @item.id)
      sleep 0.1
    end

    describe '購入情報と配送先情報の保存' do
      context '購入情報と配送先情報の保存できるとき' do
        it '全項目が存在すれば保存できる' do
          expect(@order_shipping_address).to be_valid
        end

        it 'building_nameは空でも保存できる' do
          @order_shipping_address.building_name = ''
          expect(@order_shipping_address).to be_valid
        end
      end

      context '購入情報と配送先情報の保存できないとき' do
        it '郵便番号が空だと保存できない' do
          @order_shipping_address.postal_code = ''
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("Postal code can't be blank")
        end

        it '郵便番号の形式が不正だと保存できない' do
          @order_shipping_address.postal_code = '1234567'
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
        end

        it '都道府県が選ばれていないと保存できない' do
          @order_shipping_address.prefecture_id = nil
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")

          @order_shipping_address.prefecture_id = 1
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
        end

        it '市区町村が空だと保存できない' do
          @order_shipping_address.city = ''
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
        end

        it '番地が空だと保存できない' do
          @order_shipping_address.address_line = ''
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("Address line can't be blank")
        end

        it '電話番号が空だと保存できない' do
          @order_shipping_address.phone_number = ''
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
        end

        it '電話番号が不正な形式だと保存できない' do
          @order_shipping_address.phone_number = 'abcdefghij'
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid")

          @order_shipping_address.phone_number = '１２３４５６７８９０'
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid")

          @order_shipping_address.phone_number = '123'
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid")
        end

        it 'ユーザーが紐付いていなければ投稿できない' do
          @order_shipping_address.user_id = nil
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
        end

        it 'itemが紐付いていなければ投稿できない' do
          @order_shipping_address.item_id = nil
          @order_shipping_address.valid?
          expect(@order_shipping_address.errors.full_messages).to include("Item can't be blank")
        end
      end

      context '保存処理ができる場合' do
        it 'すべての情報が正しく渡された場合に保存される' do
          expect { @order_shipping_address.save }.to change(Order, :count).by(1).and change(ShippingAddress, :count).by(1)
        end
      end
    end
  end