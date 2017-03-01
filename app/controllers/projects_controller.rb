class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_id

  def show
    @project = @team.projects.find(params[:id])
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

  protected

  def find_team_id
    @team = Team.find(params[:team_id])
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
