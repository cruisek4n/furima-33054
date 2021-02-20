FactoryBot.define do
  factory :purchase_address do
    post_code { '123-4567' }
    prefecture_id { 3 }
    city { '東京都練馬区' }
    street_address { '新江古田1-7-8' }
    building_name { '花束ビル210' }
    phone_number { '08059879999' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
