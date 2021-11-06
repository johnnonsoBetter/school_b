FactoryBot.define do
  factory :announcement do
    message { "MyString" }
    expiration { "2021-11-05" }
    announcement_image { nil }
    school { nil }
  end
end
