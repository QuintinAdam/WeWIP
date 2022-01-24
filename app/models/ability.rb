# frozen_string_literal: true

class Ability
  include CanCan::Ability

    def initialize(user)
      return unless user.present?
      if user.admin?
        # can :manage, User
        can :manage, :all
      else
        #  guests +
        can :read, Project
        can :read, Task
        can :read, Message
      return unless user.member?
        #  memebrs +
        can :manage, Task, user: user
        can :manage, Message, user: user
      end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
