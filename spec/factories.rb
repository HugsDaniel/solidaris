FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    email { Faker::Internet.email }
    password { "password" }
  end

  factory :manager, class: User do
    first_name { "Manager" }
    last_name { "User" }
    email { Faker::Internet.email }
    password { "password" }
    manager { true }
  end

  factory :organization do
    name { Faker::Name.first_name }
    description { 'Superbe asso de ouf malade, adorable' }
    kind { "association" }
    category { "Collecte" }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }

    factory :invalid_organization do
      category { nil }
    end
  end

  factory :mission do
    category { "Collecte" }
    address { "Nantes" }
    starting_at { Date.today }
    recurrent { false }
    # organization { create(:organization) }

    factory :invalid_mission do
      category { nil }
    end

    factory :current_mission do
      recurrent { true }
      starting_at { Date.today - 7 }
      recurrency_ending_on { Date.today + 7 }
    end
  end
end
