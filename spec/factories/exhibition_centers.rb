FactoryBot.define do
  factory :exhibition_center do
    name { Faker::Address.unique.community }
    address { Faker::Address.full_address }
    opening_hours { "9:00 AM - 5:00 PM" }
    contact_email { Faker::Internet.unique.email }
    contact_phone { Faker::PhoneNumber.cell_phone_in_e164 }
  end
end
