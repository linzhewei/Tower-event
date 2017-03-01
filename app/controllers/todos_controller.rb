class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_and_project

  def show
    @todo = todo
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = @project.todos.new(todo_params)
    @todo.user = current_user
    if @todo.save!
      flash[:notice] = "成功创建任务"
      redirect_to team_project_path(@team, @project)
    else
      render :new
    end
  end

  def edit
    @todo = todo
  end

  def update
    @todo = todo
    if @todo.update
      flash[:notice] = "成功更新任务"
      redirect_to team_project_path(@team, @project)
    else
      render :edit
    end
  end

  def destroy
    @todo = todo
    @todo.destroy
    flash[:alert] = "成功删除任务"
    redirect_to team_project_path(@team, @project)
  end

  protected

  def find_team_and_project
    @team = Team.find(params[:team_id])
    @project = @team.projects.find(params[:project_id])
  end

  private

  def todo
    @project.todos.find(params[:id]).tap do |todo|
    end
  end

  def todo_params
    params.require(:todo).permit(:title, :description)
  end
end
