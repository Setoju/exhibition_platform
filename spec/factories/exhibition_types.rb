FactoryBot.define do
  factory :exhibition_type do
    name { Faker::Lorem.unique.word }
    description { Faker::Lorem.sentence }
  end
end
