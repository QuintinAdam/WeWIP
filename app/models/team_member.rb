# == Schema Information
#
# Table name: team_members
#
#  id         :bigint           not null, primary key
#  role       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_team_members_on_team_id  (team_id)
#  index_team_members_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#  fk_rails_...  (user_id => users.id)
#
class TeamMember < ApplicationRecord
  ROLES = [:admin, :member]
  has_prefix_id :tm

  # Associations
  belongs_to :team
  belongs_to :user

  # Validations
  validates :user_id, uniqueness: {scope: :team_id}

  # Store the roles in the roles json column and cast to booleans
  store_accessor :roles, *ROLES

  # Cast roles to/from booleans
  ROLES.each do |role|
    scope role, -> { where("roles @> ?", {role => true}.to_json) }

    define_method(:"#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"#{role}?") { send(role) }
  end

  def active_roles
    ROLES.select { |role| send(:"#{role}?") }.compact
  end

  def account_owner?
    team.user_id == user_id
  end
end
