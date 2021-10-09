FactoryBot.define do
  factory :item_sold do
    sale_report { nil }
    item { nil }
    quantity { 1 }
    total { 1 }
  end
end
