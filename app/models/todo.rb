# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  user_id     :integer
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Todo < ApplicationRecord
  validates :title, presence: true
  belongs_to :project
  belongs_to :user
end
