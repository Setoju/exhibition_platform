FactoryBot.define do
  factory :room do
    name { Faker::Name.name }
    width { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    height { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    depth { Faker::Number.decimal(l_digits: 2, r_digits: 2) }

    association :exhibition_center
  end
end
