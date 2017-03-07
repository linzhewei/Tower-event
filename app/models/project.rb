# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  user_id     :integer
#  team_id     :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ApplicationRecord
  validates :name, presence: true
  belongs_to :team
  belongs_to :user
  has_many :todos

  has_many :project_relationships
  has_many :project_members, through: :project_relationships, source: :user
end
