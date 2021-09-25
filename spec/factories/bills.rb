FactoryBot.define do
  factory :bill do
    title { "MyString" }
    description { "MyString" }
    total_amount { 900 }
    payment_completed { false }
    student { nil }
  end
end
