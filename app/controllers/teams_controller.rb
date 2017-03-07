class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_team_member, only: [:show, :all_members]

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @projects = @team.projects.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      current_user.join_team!(@team)
      flash[:notice] = "成功建立团队"
      redirect_to teams_path
    else
      render :new
    end
  end

  def join
    @team = Team.find(params[:id])

    if !current_user.is_member_of_team?(@team)
      current_user.join_team!(@team)
      flash[:notice] = "成功加入团队"
    else
      flash[:notice] = "你已经是团队成员"
    end

    redirect_to :back
  end

  def quit
    @team = Team.find(params[:id])

    if current_user.is_member_of_team?(@team)
      current_user.quit_team!(@team)
      flash[:notice] = "已退出该团队"
    else
      flash[:notice] = "不是成员，无法退出"
    end

    redirect_to :back
  end

  def all_members
    @team = Team.find(params[:id])
    @members = @team.members.all
  end

  protected

  def require_is_team_member
    if !current_user.is_member_of_team?(Team.find(params[:id]))
      redirect_to root_path
      flash[:notice] = "暂无权限"
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
