# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_projects_on_slug  (slug)
#
FactoryBot.define do
  factory :project do
    name { "MyString" }
    slug { "MyString" }
  end
end
