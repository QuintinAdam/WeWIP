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
  has_prefix_id :team
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  normalizy :name

  # Associations
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :team_members, dependent: :destroy
  has_many :members, through: :team_members, source: :user

  validates_uniqueness_of :name, case_sensitive: false

  private

  def should_generate_new_friendly_id?
    slug.blank? || self.name_changed?
  end
end
