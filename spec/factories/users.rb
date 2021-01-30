FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname {Faker::Name.initials}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6) + "1a"}
    password_confirmation {password}
    first_name { person.first.kanji }
    last_name { person.last.kanji }
    first_name_kana { person.first.katakana }
    last_name_kana { person.last.katakana }
    birth_date { Faker::Date.backward }
  end
end