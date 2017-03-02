module TodosHelper
  def render_todo_state(todo)
    case todo.aasm_state
    when "created"
      content_tag(:span, "已创建", class:"label label-default")
    when "running"
      content_tag(:span, "进行中", class:"label label-primary")
    when "finished"
      content_tag(:span, "已完成", class:"label label-danger")
    when "deleted"
      content_tag(:span, "已删除", class:"label label-success")
    end
  end

  def render_todo_finish(team, project, todo)
    unless todo.aasm_state == "finished" || todo.aasm_state == "deleted"
      link_to "完成", finish_team_project_todo_path(team, project, todo), method: :post, class:"btn btn-xs btn-default"
    end
  end

  def render_todo_reopen(team, project, todo)
    if todo.aasm_state == "finished"
      link_to "重新开始", reopen_team_project_todo_path(team, project, todo), method: :post, class:"btn btn-xs btn-default"
    end
  end

  def render_todo_comment(todo)
    unless todo.aasm_state == "deleted"
      link_to "添加评论", "#", class:"btn btn-xs btn-default"
    end
  end

  def render_todo_delete(team, project, todo)
    unless todo.aasm_state == "deleted"
      link_to "删除", delete_team_project_todo_path(team, project, todo), method: :post, class:"btn btn-xs btn-default"
    end
  end

  def render_todo_edit(team, project, todo)
    unless todo.aasm_state == "deleted" || todo.aasm_state == "finished"
      link_to "修改", edit_team_project_todo_path(team, project, todo), class:"btn btn-xs btn-default"
    end
  end

  def render_todo_run(team, project, todo)
    if todo.aasm_state == "created"
      link_to "开始", run_team_project_todo_path(team, project, todo), method: :post, class:"btn btn-xs btn-danger"
    end
  end

  def render_todo_pause(team, project, todo)
    if todo.aasm_state == "running"
      link_to "暂停", pause_team_project_todo_path(team, project, todo), method: :post, class:"btn btn-xs btn-danger"
    end
  end

  def render_todo_recover(team, project, todo)
    if todo.aasm_state == "deleted"
      link_to "恢复", recover_team_project_todo_path(team, project, todo), method: :post, class:"btn btn-xs btn-default"
    end
  end

end
