# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  author     :string           not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_messages_on_project_id  (project_id)
#  index_messages_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  has_prefix_id :m
  belongs_to :user
  belongs_to :project

  after_commit on: :create do
    broadcast_prepend_to project, partial: "messages/message", locals: {message: self}, target: "messages"
  end
end
