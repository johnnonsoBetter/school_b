FactoryBot.define do
  factory :behaviour_report do
    title { "MyString" }
    description { "MyString" }
    behaviour_type { "" }
    student { nil }
    teacher { nil }
  end
end
