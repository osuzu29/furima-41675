FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name    {"田中"} 
    first_name    {"太郎"}
    last_name_kana    {"タナカ"} 
    first_name_kana    {"タロウ"}
    birth    {"2000-02-09"}
  end
end
