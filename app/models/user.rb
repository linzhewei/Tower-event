# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :team_relationships
  has_many :participated_teams, through: :team_relationships, source: :team
  has_many :project_relationships
  has_many :participated_projects, through: :project_relationships, source: :project

  def is_member_of_project?(project)
    participated_projects.include?(project)
  end

  def join_project!(project)
    participated_projects << project
  end

  def quit_project!(project)
    participated_projects.delete(project)
  end

  def is_member_of_team?(team)
    participated_teams.include?(team)
  end

  def join_team!(team)
    participated_teams << team
  end

  def quit_team!(team)
    participated_teams.delete(team)
  end
end
