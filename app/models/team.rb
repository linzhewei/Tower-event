# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  founder    :string
#

class Team < ApplicationRecord
  validates :name, presence: true
  has_many :projects

  has_many :team_relationships
  has_many :members, through: :team_relationships, source: :user
end
