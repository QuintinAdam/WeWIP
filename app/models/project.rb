# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_projects_on_slug  (slug)
#
class Project < ApplicationRecord
  has_prefix_id :p
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  normalizy :name

  # Associations
  has_many :messages, dependent: :destroy


  validates_uniqueness_of :name, case_sensitive: false

  private

  def should_generate_new_friendly_id?
    slug.blank? || self.name_changed?
  end
end
