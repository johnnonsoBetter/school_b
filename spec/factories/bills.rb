FactoryBot.define do
  factory :bill do
    title { "MyString" }
    description { "MyString" }
    total { "MyString" }
    payment_completed { false }
    student { nil }
  end
end
