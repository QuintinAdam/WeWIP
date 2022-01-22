FactoryBot.define do
  factory :message do
    content { "MyText" }
    author { "MyString" }
    user { nil }
  end
end
