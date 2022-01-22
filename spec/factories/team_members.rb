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
FactoryBot.define do
  factory :team_member do
    team { nil }
    user { nil }
    role { "" }
  end
end
