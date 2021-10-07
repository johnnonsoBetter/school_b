FactoryBot.define do
  factory :bill do
   
    payment_completed { false }
    student { nil }
  end
end
