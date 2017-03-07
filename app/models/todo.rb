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
#  aasm_state  :string           default("created")
#  assignee    :string           default("未指派")
#  deadline    :datetime
#

class Todo < ApplicationRecord
  validates :title, presence: true
  # validate :deadline_need_after_time_now
  belongs_to :project
  belongs_to :user
  has_many :comments


  include AASM

  aasm do
    state :created, :initial => true
    state :running, :finished, :deleted

    event :run do
      transitions :from => :created, :to => :running
    end

    event :pause do
      transitions :from => :running, :to => :created
    end

    event :finish do
      transitions :form => [:created, :running], :to => :finished
    end

    event :delete do
      transitions :from => [:created, :running, :finished], :to => :deleted
    end

    event :reopen do
      transitions :from => :finished, :to => :created
    end

    event :recover do
      transitions :from => :deleted, :to => :created
    end
  end

  # def deadline_need_after_time_now
  #   if deadline.present?
  #     if deadline < created_at
  #       self.errors.add(:deadline, :deadline_need_after_time_now)
  #     end
  #   end
  # end

end
