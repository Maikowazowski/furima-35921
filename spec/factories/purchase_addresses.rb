FactoryBot.define do
  factory :purchase_address do
    transient do
      address { Gimei.address }
    end

    postal_code   {'123-4567'}
    prefecture    {Faker::Number.between(from: 2, to: 48)}
    city          {address.city.kanji}
    house_number  {address.town.kanji + '1-1' }
    building_name {address.prefecture.kanji + 'ハイツ' }
    phone_number  {Faker::Number.leading_zero_number(digits: 11)}
    token         {'tok_' + Faker::Lorem.characters(number: 28)}
  end
end
