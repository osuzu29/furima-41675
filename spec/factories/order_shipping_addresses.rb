FactoryBot.define do
  factory :order_shipping_address do
    postal_code { '123-4567' }
    prefecture_id { 10 }
    city { '横浜市緑区' }
    address_line { '青山1-1-1' }
    building_name { '柳ビル103' }
    phone_number { '09012345678' }
    user_id { FactoryBot.create(:user).id }
    item_id { FactoryBot.create(:item).id }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
