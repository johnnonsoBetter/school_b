FactoryBot.define do
  factory :score_report do
    max { 1 }
    score { 1 }
    remark { "MyString" }
    teacher { nil }
    term_activity { nil }
  end
end
