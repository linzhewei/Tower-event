# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  todo_id    :integer
#

class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :todo
end
