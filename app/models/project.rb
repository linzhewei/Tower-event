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
  validates :title, presence: true
  belongs_to :team
  belongs_to :user
end
