FactoryBot.define do
  factory :favourite do
    association :user
    association :exhibition
  end
end
