FactoryBot.define do
  factory :item do 
    name                {Faker::Name.name}
    description         {Faker::Lorem.sentence}
    category_id         {10}
    condition_id        {3}
    shipping_fee_id     {3}
    prefecture_id       {33}
    shipping_day_id     {4}
    price               {2500}
    association         :user, factory: :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    
  end
end