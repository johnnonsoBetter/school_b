FactoryBot.define do
    factory :guidance do
      
      password { "password" }
      sequence :email do |n|
        "person#{n}@example.com"
      end
    end
  end
  