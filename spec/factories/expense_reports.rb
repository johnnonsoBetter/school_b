FactoryBot.define do
  factory :expense_report do
    amount { 1 }
    title { "MyString" }
    school { nil }
    admin { nil }
  end
end
