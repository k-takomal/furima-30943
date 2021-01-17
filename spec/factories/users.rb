FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = { '1a'+ Faker::Internet.password(min_length: 4)
    password {password}
    password_confirmation {password}
    unique_name = Gimei.unique.name
    last_name {unique_name.last.kanji}
    first_name {unique_name.first.kanji}
    last_name_kana {unique_name.last.katakana}
    first_name_kana {unique_name.first.katakana}
    birthday {Faker::Date.between(from: '1930-01-01',to:'2016-12-31')}
    
  end
end
