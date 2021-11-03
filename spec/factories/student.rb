FactoryBot.define do
    factory :student do
      email { "my@gmail.com" }
      password { "password" }
      image {"httpssfsfsfsdf"}
      state {"string"}
      date_of_admission {Date.new}
      date_of_birth {Date.new}
      religion {"string"}
      lga {"string"}
      first_name {"string"}
      last_name {"string"}
      middle_name {"string"}
      address {"string"}
      active {true}
    end
  end
  