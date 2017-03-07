class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_id
  before_action :require_is_project_member, only: [:show, :all_members]

  def show
    @project = @team.projects.find(params[:id])
    @todos = @project.todos.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = @team.projects.new(project_params)
    @project.user = current_user
    if @project.save
      flash[:notice] = "成功创建项目"
      redirect_to team_path(@team)
    else
      render :new
    end
  end

  def join
    @project = @team.projects.find(params[:id])

    if !current_user.is_member_of_project?(@project)
      current_user.join_project!(@project)
      flash[:notice] = "成功加入项目"
    else
      flash[:notice] = "你已经是项目成员"
    end

    redirect_to :back
  end

  def quit
    @project = @team.projects.find(params[:id])

    if current_user.is_member_of_project?(@project)
      current_user.quit_project!(@project)
      flash[:notice] = "已退出该项目"
    else
      flash[:notice] = "不是成员，无法退出"
    end

    redirect_to :back
  end

  def all_members
    @project = @team.projects.find(params[:id])
    @members = @project.project_members.all
  end

  protected

  def find_team_id
    @team = Team.find(params[:team_id])
  end

  def require_is_project_member
    if !current_user.is_member_of_project?(Project.find(params[:id]))
      redirect_to root_path
      flash[:notice] = "暂无权限"
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
