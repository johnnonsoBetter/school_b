FactoryBot.define do
    factory :admin do
      email { "my@gmail.com" }
      password { "password" }
      permitted {true}
      role {"admin"}
    end
  end
  