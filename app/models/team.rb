# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_teams_on_slug     (slug) UNIQUE
#  index_teams_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Team < ApplicationRecord
  extend FriendlyId
  has_prefix_id :team
  friendly_id :name, use: :slugged
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :team_members, dependent: :destroy
  has_many :members, through: :team_members, source: :user
end
