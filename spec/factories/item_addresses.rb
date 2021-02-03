FactoryBot.define do
  factory :item_address do
      postal_code {'123-4567'}
      area_id {rand(1..47)}
      cities {'千代田区'}
      house_number {'青山−１−１'}
      tel {Faker::Number.leading_zero_number(digits: 10)}
     
       token {'sampletokensampletoken'}
    
  end
end
