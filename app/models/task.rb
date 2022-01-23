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
class Task < ApplicationRecord
  has_prefix_id :task
  belongs_to :user
  belongs_to :project

  scope :pending, -> {where(completed_at: nil)}
  after_commit on: :create do
    broadcast_prepend_to project, partial: "tasks/task", locals: {task: self}, target: "tasks"
  end
end
