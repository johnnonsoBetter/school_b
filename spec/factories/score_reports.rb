FactoryBot.define do
  factory :score_report do
    max { 50 }
    score { 30 }
    remark { "MyString" }
    teacher { nil }
   
  end
end
