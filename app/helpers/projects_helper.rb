module ProjectsHelper
  def render_project_member_or_not(user, project)
    if current_user && user.is_member_of_project?(project)
      content_tag(:span, "项目成员", class:"label label-success pull-right")
    else
      content_tag(:span, "不是项目成员", class:"label label-warning pull-right")
    end
  end

  def render_join_or_quit_project(user, team, project)
    if current_user && user.is_member_of_project?(project)
      link_to "退出项目", quit_team_project_path(team, project), method: :post, class:"btn btn-xs btn-default"
    else
      link_to "加入项目", join_team_project_path(team, project), method: :post, class:"btn btn-xs btn-default"
    end
  end

  def render_all_project_members(user, team, project)
    if current_user && user.is_member_of_project?(project)
      link_to "所有成员", all_members_team_project_path(team, project), class:"btn btn-xs btn-primary pull-right"
    end
  end
end
