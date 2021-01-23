FactoryBot.define do
  factory :item do
  name {Faker::Name.last_name}
  text {Faker::Quotes::Shakespeare.hamlet_quote}
  category_id {rand(1..10)}
  condition_id {rand(1..10)}
  postage_id {rand(1..10)}
  area_id {rand(1..10)}
  day_id {rand(1..10)}
  price {rand(300..9999999)}
  association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
