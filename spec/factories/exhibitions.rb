FactoryBot.define do
  factory :exhibition do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    start_date { Faker::Date.forward(days: 1) }
    end_date { Faker::Date.forward(days: 30) }

    association :exhibition_center
    association :exhibition_type
    association :room
  end
end
