# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  author       :string           not null
#  completed_at :datetime
#  content      :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  project_id   :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :task do
    content { "MyString" }
    author { "MyString" }
    user { nil }
    completed_at { "2022-01-22 21:09:43" }
  end
end
