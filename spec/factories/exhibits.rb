FactoryBot.define do
  factory :exhibit do
    name { Faker::Art.title }
    description { Faker::Lorem.paragraph }
    width { Faker::Number.between(from: 10.0, to: 200.0) }
    height { Faker::Number.between(from: 10.0, to: 200.0) }
    depth { Faker::Number.between(from: 10.0, to: 200.0) }
    weight { Faker::Number.between(from: 1.0, to: 100.0) }
    material { Faker::Commerce.material }
    creation_date { Faker::Date.backward(days: 3650) }
    copy { Faker::Boolean.boolean }

    association :exhibition_type
    association :room
    association :exhibition
  end
end
