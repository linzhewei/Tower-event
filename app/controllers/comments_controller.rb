class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_and_project_and_todo

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.todo = @todo

    if @comment.save
      flash[:notice] = "评论成功发表"
      redirect_to team_project_todo_path(@team, @project, @todo)
    else
      render :new
    end
  end

  protected

  def find_team_and_project_and_todo
    @team = Team.find(params[:team_id])
    @project = @team.projects.find(params[:project_id])
    @todo = @project.todos.find(params[:todo_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
