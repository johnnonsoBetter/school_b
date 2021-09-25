FactoryBot.define do
  factory :school do
    sequence :name do |n|
      "school #{n}"
    end
  end
end
