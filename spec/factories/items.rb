FactoryBot.define do
  factory :item do
    name                                 { Faker::Lorem.word }
    information                          { Faker::Lorem.sentence }
    category_id                          { Faker::Number.within(range: 2..11) }
    item_condition_id                    { Faker::Number.within(range: 2..7) }
    delivery_charge_pay_method_id        { Faker::Number.within(range: 2..3) }
    prefecture_id                        { Faker::Number.within(range: 2..49) }
    scheduled_delivery_id                { Faker::Number.within(range: 2..4) }
    price                                { Faker::Number.within(range: 300..9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
