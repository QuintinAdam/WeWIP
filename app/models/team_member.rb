class TeamMember < ApplicationRecord
  ROLES = [:admin, :member]
  has_prefix_id :tm
  belongs_to :team
  belongs_to :user

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
