FactoryBot.define do
  factory :sale_report do
    total { 1 }
    school { nil }
    admin { nil }
    items_sold { "" }
  end
end
