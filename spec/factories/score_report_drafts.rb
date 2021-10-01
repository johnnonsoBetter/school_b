FactoryBot.define do
  factory :score_report_draft do
    subject { nil }
    score_type { nil }
    published { false }
    max { 1 }
  end
end
