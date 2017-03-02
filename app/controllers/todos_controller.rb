class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_and_project
  before_action :find_todo, except: [:new, :create]
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
    if @todo.update(todo_params)
      flash[:notice] = "成功更新任务"
      redirect_to team_project_path(@team, @project)
    else
      render :edit
    end
  end

  def run
    @todo = @todo
    @todo.run!
    flash[:notice] = "任务开始"
    redirect_to :back
  end

  def pause
    @todo = @todo
    @todo.pause!
    flash[:notice] = "任务暂停"
    redirect_to :back
  end

  def finish
    @todo = @todo
    @todo.finish!
    flash[:notice] = "任务完成"
    redirect_to :back
  end

  def delete
    @todo = @todo
    @todo.delete!
    flash[:notice] = "任务删除成功"
    redirect_to :back
  end

  def reopen
    @todo = @todo
    @todo.reopen!
    flash[:notice] = "任务重新开始"
    redirect_to :back
  end

  def recover
    @todo = @todo
    @todo.recover!
    flash[:notice] = "恢复任务"
    redirect_to :back
  end

  protected

  def find_team_and_project
    @team = Team.find(params[:team_id])
    @project = @team.projects.find(params[:project_id])
  end

  def find_todo
    @todo = @project.todos.find(params[:id])
  end

  def todo
    @project.todos.find(params[:id]).tap do |todo|
    end
  end


  private

  def todo_params
    params.require(:todo).permit(:title, :description)
  end
end
